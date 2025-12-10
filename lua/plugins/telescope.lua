return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },

  config = function()
    local Layout = require("nui.layout")
    local Popup = require("nui.popup")
    local TSLayout = require("telescope.pickers.layout")

    local function make_popup(options)
      local popup = Popup(options)

      -- Inject-field
      -- NuiPopup no tiene explícitamente definido 'change_title' en su clase base,
      -- así que le decimos al LSP que ignore esta inyección de campo.
      ---@diagnostic disable-next-line: inject-field
      function popup.border:change_title(title)
        popup.border.set_text(popup.border, "top", title)
      end

      -- Param-type-mismatch
      -- TSLayout.Window espera un objeto interno de Telescope, pero nui.nvim
      -- devuelve un objeto compatible (duck typing). Forzamos el tipo a 'any'.
      return TSLayout.Window(popup --[[@as any]])
    end

    require("telescope").setup({
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          horizontal = { size = { width = "91%", height = "90%" } },
          vertical = { size = { width = "90%", height = "90%" } },
        },
        create_layout = function(picker)
          local border = {
            results = {
              top_left = "┌",
              top = "─",
              top_right = "┬",
              right = "│",
              bottom_right = "",
              bottom = "",
              bottom_left = "",
              left = "│",
            },
            results_patch = {
              minimal = { top_left = "┌", top_right = "┐" },
              horizontal = { top_left = "┌", top_right = "┬" },
              vertical = { top_left = "├", top_right = "┤" },
            },
            prompt = {
              top_left = "├",
              top = "─",
              top_right = "┤",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            prompt_patch = {
              minimal = { bottom_right = "┘" },
              horizontal = { bottom_right = "┴" },
              vertical = { bottom_right = "┘" },
            },
            preview = {
              top_left = "┌",
              top = "─",
              top_right = "┐",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            preview_patch = {
              minimal = {},
              horizontal = {
                bottom = "─",
                bottom_left = "",
                bottom_right = "┘",
                left = "",
                top_left = "",
              },
              vertical = {
                bottom = "",
                bottom_left = "",
                bottom_right = "",
                left = "│",
                top_left = "┌",
              },
            },
          }

          local results = make_popup({
            focusable = false,
            border = {
              style = border.results,
              text = { top = picker.results_title, top_align = "center" },
            },
            win_options = { winhighlight = "Normal:Normal" },
          })

          local prompt = make_popup({
            enter = true,
            border = {
              style = border.prompt,
              text = { top = picker.prompt_title, top_align = "center" },
            },
            win_options = { winhighlight = "Normal:Normal" },
          })

          local preview = make_popup({
            focusable = false,
            border = {
              style = border.preview,
              text = { top = picker.preview_title, top_align = "center" },
            },
          })

          local box_by_kind = {
            vertical = Layout.Box({
              Layout.Box(preview, { grow = 1 }),
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = "col" }),
            horizontal = Layout.Box({
              Layout.Box({
                Layout.Box(results, { grow = 1 }),
                Layout.Box(prompt, { size = 3 }),
              }, { dir = "col", size = "50%" }),
              Layout.Box(preview, { size = "50%" }),
            }, { dir = "row" }),
            minimal = Layout.Box({
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = "col" }),
          }

          local function get_box()
            local strategy = picker.layout_strategy
            if strategy == "vertical" or strategy == "horizontal" then
              return box_by_kind[strategy], strategy
            end

            local height, width = vim.o.lines, vim.o.columns
            local box_kind = "horizontal"
            if width < 100 then
              box_kind = "vertical"
              if height < 40 then
                box_kind = "minimal"
              end
            end
            return box_by_kind[box_kind], box_kind
          end

          local function prepare_layout_parts(layout, box_type)
            layout.results = results
            -- Undefined-field
            -- nui.nvim tiene el método set_style, pero a veces el LSP no lo detecta
            -- en las definiciones de tipos.
            ---@diagnostic disable-next-line: undefined-field
            results.border:set_style(border.results_patch[box_type])

            layout.prompt = prompt
            ---@diagnostic disable-next-line: undefined-field
            prompt.border:set_style(border.prompt_patch[box_type])

            if box_type == "minimal" then
              layout.preview = nil
            else
              layout.preview = preview
              ---@diagnostic disable-next-line: undefined-field
              preview.border:set_style(border.preview_patch[box_type])
            end
          end

          local function get_layout_size(box_kind)
            return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
          end

          local box, box_kind = get_box()
          local layout = Layout({
            relative = "editor",
            position = "50%",
            size = get_layout_size(box_kind),
            win_options = {
              winhighlight = "Normal:Normal,NormalFloat:Normal,FloatBorder:FloatBorder",
            },
          }, box)

          -- Inject-field
          -- Guardamos el picker dentro del layout para usarlo luego.
          -- Esto es un 'hack' común en Lua, lo permitimos.
          ---@diagnostic disable-next-line: inject-field
          layout.picker = picker

          prepare_layout_parts(layout, box_kind)

          local layout_update = layout.update
          function layout:update()
            -- Redefined-local
            -- Simplemente renombramos las variables locales para evitar el shadowing
            -- (usar el mismo nombre que una variable superior).
            local new_box, new_box_kind = get_box()
            prepare_layout_parts(layout, new_box_kind)
            layout_update(self, { size = get_layout_size(new_box_kind) }, new_box)
          end

          -- Param-type-mismatch
          return TSLayout(layout --[[@as any]])
        end,
      },
    })
  end,
}
