module ApplicationHelper

	def bs_page_header tag, name
		content_tag :div, class: "page-header" do
			content_tag tag, name
		end 
	end

end
