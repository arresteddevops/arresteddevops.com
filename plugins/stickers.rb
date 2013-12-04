# encoding: utf-8
module Jekyll

  class StickerListTag < Liquid::Tag

    def render(context)
      html = ""

      # get source directory path
      source = context.registers[:site].source

      # join build stickers direcctory path; TODO: should chek existance of path
      stickers_dir = "#{source}/images/stickers"

      # get all file names from stickers folder and ignore folders
      stickers = Dir.entries(stickers_dir).select {|f| !File.directory? f}

      # let's build html element for each of the file in list
      stickers.sort.each do |sticker|
      	# drop string apart to define if there is url in the name of file
      	# exclude file extension: TODO should use reqular expression
        url_part_name = sticker.split(".")[0..-2]

        # if there are 2 or more elements in the list, than add to html img tag wraped by anchor tag
        # otherwise just build a img tag
        if url_part_name.size >= 2
          url_to = "http://#{url_part_name.join('.')}"
          html << "<a href='#{url_to}'><img style='padding: .5em; margin: .5em;' src='/images/stickers/#{sticker}'></a>"
        else
          html << "<img style='padding: .5em; margin: .5em;' src='/images/stickers/#{sticker}' >"
        end
      end
      html
    end
  end
end

# register the "stickers" tag
Liquid::Template.register_tag('stickers', Jekyll::StickerListTag)
