class Help
	def self.print_instructions
		puts("Help Instructions - Dragon Byte Wizard")
		puts("\tStarting Point")
		puts("\t\tThis is a program to help you automatically create required files of the cursor for different ports.")
		puts("\tDependencies")
		puts("\t\tThis program needs that some dependencies are satisfied to work properly. More information can be found in the README file in the repository's root directory.")
		puts("\tSyntax")
		puts("\t\tUse this program with the following syntax:")
		puts("\t\t\truby wizard.rb [flags] <command>")
		puts("\t\tThe flags it can accept are:")
		puts("\t\t\t--help: print these help instructions.")
		puts("\t\tThe commands it can accept are:")
		puts("\t\t\tcreate-web-port: creates all the required files for a web port.")
		puts("\t\t\tcreate-x11-port: creates all the required files for an X11 port.")
		puts("\t\tAll the ports created are placed under a directory called \"distributions\" in the repository's root directory.")
	end
end

