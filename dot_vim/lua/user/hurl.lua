local hurl_ok, hurl = pcall(require, "hurl")
if not hurl_ok then
	return
end

hurl.setup()
