class Chef
	class Recipe
		def backup(home,entry)
			if File.exists?("#{home}/#{entry}") and not File.symlink?("#{home}/#{entry}")
				Fileutils.mv("#{home}/#{entry}","#{home}/.dotfiles/#{entry}.#{Date.now}.bckp")
			end
		end
	end
end
