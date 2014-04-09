module ApplicationHelper

	def bs_page_header tag, name
		content_tag :div, class: "page-header" do
			content_tag tag, name
		end 
	end

	def rud_links model, opts={}, delimiter=" | "
		defaults = {
			read: {},
			update: {},
			delete: {method: :delete, data: {confirm: "Are you sure?"}}
		}

		defaults.each do |action, default|
			default.merge!(opts[action] || {})
		end

		edit_path = send("edit_#{model.class.name.downcase}_path", model)
		
		links = {
			read: link_to("#{time_ago_in_words(model.created_at)} ago", model, defaults[:read]),
			update: link_to("Edit", edit_path, defaults[:update]),
			delete: link_to("Delete", model, defaults[:delete])
		}

     	html = links.keep_if do |action, link|
     		opts[action] != false
     	end.values.join(delimiter)

     	raw html
	end
	

end
