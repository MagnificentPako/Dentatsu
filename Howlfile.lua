Options:Default "trace"

Tasks:clean()

Tasks:minify "minify" {
	input = "build/Dentatsu.lua",
	output = "build/Dentatsu.min.lua",
}

Tasks:require "main" {
	include = "dentatsu/*.lua",
	startup = "dentatsu/dentatsu.lua",
	output = "build/Dentatsu.lua",
	rename = function(file)
		return file.name == "dentatsu.dentatsu" and file.name or file.name:sub((".dentatsu"):len()+1, #file.name)
	end
}

Tasks:Task "build" { "clean", "minify" } :Description "Main build task"

Tasks:gist "upload" (function(spec)
	spec:summary "A simple communication abstraction for CC"
	spec:gist "83a2601b7873abdb8acd0124ff2279bd"
	spec:from "build" {
		include = { "Dentatsu.lua", "Dentatsu.min.lua" }
	}
end) :Requires { "build/Dentatsu.lua", "build/Dentatsu.min.lua" }
