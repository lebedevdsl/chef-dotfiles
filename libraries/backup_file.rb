class Chef
	class Recipe
		def backup(home,entry)
			if File.exists?("#{home}/#{entry}") and not File.symlink?("#{home}/#{entry}")
				t = Time.now
				FileUtils.mv("#{home}/#{entry}","#{home}/.dotfiles/#{entry}.#{t.day}-#{t.month}-#{t.year}.bckp")
			end
		end
	end
end
