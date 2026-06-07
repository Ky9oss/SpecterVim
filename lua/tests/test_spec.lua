require("utils.file")

describe("Module: utils.file", function()
	describe("Function: find_files_upward", function()
		it("Test1", function()
			local files = { "grub.cfg", "grubenv" }
			local result = find_files_upward(files, vim.fs.dirname("/boot/grub/i386-pc/test.mod"))
			assert.is_true(result == "/boot/grub/grub.cfg")
		end)

		it("Test2", function()
			files = { "grubenv", "grub.cfg" }
			result = find_files_upward(files, vim.fs.dirname("/boot/grub/i386-pc/test.mod"))
			assert.is_true(result == "/boot/grub/grubenv")
		end)

		it("Test3", function()
			files = { "grubenv2", "grub.cfg2" }
			result = find_files_upward(files, vim.fs.dirname("/boot/grub/i386-pc/test.mod"))
			assert.is_true(result == nil)
		end)

		it("Test4", function()
			files = { "initrd.img" }
			result = find_files_upward(files, vim.fs.dirname("/boot/grub/i386-pc/test.mod"))
			assert.is_true(result == "/initrd.img")
		end)

		it("Test5", function()
			files = { "grubenv", "grub.cfg", "zfs.mod" }
			result = find_files_upward(files, vim.fs.dirname("/boot/grub/i386-pc/test.mod"))
			assert.is_true(result == "/boot/grub/i386-pc/zfs.mod")
		end)
	end)
end)

	-- describe("should be awesome", function()
	--
	--
	--   it("should be easy to use", function()
	--     assert.truthy("Yup.")
	--   end)
	--
	--   it("should have lots of features", function()
	--     -- deep check comparisons!
	--     assert.are.same({ table = "great"}, { table = "great" })
	--
	--     -- or check by reference!
	--     assert.are_not.equal({ table = "great"}, { table = "great"})
	--
	--     assert.truthy("this is a string") -- truthy: not false or nil
	--
	--     assert.True(1 == 1)
	--     assert.is_true(1 == 1)
	--
	--     assert.falsy(nil)
	--     assert.has_error(function() error("Wat") end, "Wat")
	--   end)
	--
	--   it("should provide some shortcuts to common functions", function()
	--     assert.are.unique({{ thing = 1 }, { thing = 2 }, { thing = 3 }})
	--   end)
	--
	--   it("should have mocks and spies for functional tests", function()
	--     local thing = require("thing_module")
	--     spy.on(thing, "greet")
	--     thing.greet("Hi!")
	--
	--     assert.spy(thing.greet).was.called()
	--     assert.spy(thing.greet).was.called_with("Hi!")
	--   end)
	-- end)
