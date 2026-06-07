function log_error(message)
	info = debug.getinfo(2, "Sl")

	vim.notify(
		string.format("[SPECTERV] %s:%d\nMessage: %s", info.source, info.currentline, message),
		vim.log.levels.ERROR
	)
end

function log_warning(message)
	info = debug.getinfo(2, "Sl")

	vim.notify(
		string.format("[SPECTERV] %s:%d\nMessage: %s", info.source, info.currentline, message),
		vim.log.levels.WARN
	)
end

function log_info(message)
	info = debug.getinfo(2, "Sl")

	vim.notify(
		string.format("[SPECTERV] %s:%d\nMessage: %s", info.source, info.currentline, message),
		vim.log.levels.INFO
	)
end

function test()
	log_error("Hello")
	log_warning("Hello")
	log_info("Hello")
end
