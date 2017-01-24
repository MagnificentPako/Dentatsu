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
