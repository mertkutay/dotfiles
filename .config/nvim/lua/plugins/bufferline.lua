require("bufferline").setup({
  options = {
    numbers = "none",
    close_command = "Bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = "Bdelete! %d",
    right_mouse_command = nil,
    separator_style = "thin",
  },
})
