module NavbarHelper
	def active? path
		request.fullpath == path ? "active" : nil
	end

	def nav_button name, path
		content_tag :li, class: "#{active? path}" do
			link_to name, path
		end
	end
end