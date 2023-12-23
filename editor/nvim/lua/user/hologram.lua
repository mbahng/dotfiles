local status_ok, holo = pcall(require, "hologram")
if not status_ok then
  return
end

holo.setup {
  auto_display = true
}

