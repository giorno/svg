#!/usr/bin/ruby

# vim; et

require 'rasem'

module Io
  module Creat

    # an adapter, adds various SVG features to Rasem SVGImage
    class Svg < Rasem::SVGImage

      def initialize( params )
        super( params.merge( { :viewBox => "0 0 #{params[:width]} #{params[:height]}" } ) )
      end # initialize

      # adds viewBox attribute to the header
#      def write_header( output )
#        output << <<-HEADER
#<?xml version="1.0" standalone="no"?>
#<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
#  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
#<svg viewBox="0 0 #{@attributes[:width]} #{@attributes[:height]}" width="#{@attributes[:width]}mm" height="#{@attributes[:height]}mm" version="1.1"
#  xmlns:xlink="http://www.w3.org/1999/xlink"
#  xmlns="http://www.w3.org/2000/svg">
#        HEADER
#      end # write_header

      # register pattern to be used for fill
      public
      def pattern ( name = 'x-hatch', size = 4 )
        defs do
          pattern( :id => name, :patternUnits => "userSpaceOnUse", :width => size, :height => size ) do
            path( { :stroke => "black", :"stroke-width" => 0.02 } ) do
              moveToA( -1, 1 )
              lineTo( 2, -2 )
              moveToA( 0, size )
              lineTo( size, - size )
              moveToA( size - 1, size + 1 )
              lineTo( 2, -2 )
              moveToA( size, size )
              lineTo( - size, - size )
              moveToA( 1, size + 1 )
              lineTo( -2, -2 )
            end
          end
        end
#        @output << %Q{<defs>}
#        @output << %Q{<pattern id="#{name}" patternUnits="userSpaceOnUse" width="#{size}" height="#{size}">}
#        @output << %Q{<path d="M-1,1 l2,-2 M0,#{size} l#{size},-#{size} M#{size - 1},#{size + 1} l2,-2}
#        @output << %Q{ M#{size},#{size} l-#{size},-#{size} M1,#{size + 1} l-2,-2"}
#        @output << %Q{ style="stroke: black; stroke-width: 0.02"/>}
#        @output << %Q{</pattern>}
#        @output << %Q{</defs>}
      end

#      # begin an SVG path
#      public
#      def pbegin ( pattern = nil)
#        @output << %Q{<path }
#        if not pattern.nil? then @output << %Q{stroke-dasharray="#{pattern}" } end
#        @output << %Q{d="}
#        @in_path = true
#      end
#
#      # close an SVG path and apply the style in the process
#      public
#      def pend ( style = { "fill" => "none", "stroke" => "black", "stroke-width" => "0.11" } )
#        @output << %Q{" }
#	write_style(style)
#        @output << %Q{/>}
#        @in_path = false
#      end

#      public
#      def assert_in_path ( )
#        raise "Attempted drawing in a closed path" unless @in_path == true
#      end

#      public
#      def move ( x_mm, y_mm )
#        assert_in_path
#        @output << %Q{M#{x_mm},#{y_mm} }
#      end

      # render line with pattern
      # TODO fix the default pattern
      public
      def pline( x1, y1, x2, y2, style=DefaultStyles[:line], pattern = "" )
        line( x1, y1, x2, y2, style.merge( { :"stroke-dasharray" => pattern } ) )
      end

#      # render line segment using relative coordinates
#      public
#      def rline ( x_mm, y_mm )
#        assert_in_path
#        @output << %Q{L#{x_mm},#{y_mm} }
#      end
#
#      public
#      def arc ( x_mm, y_mm, r_mm, dir = "0,1" )
#        assert_in_path
#        @output << %Q{A#{r_mm},#{r_mm} 0 #{dir} #{x_mm},#{y_mm} }
#      end

      # Primitive mapping the functionality of simple text output.
      public
      def _text ( x, y, text, style )
        text( x, y, style ) { raw text }
      end # _text

      # Primitive mapping the functionality of rotated text.
      public
      def _rtext ( x, y, deg, text, style )
        text( x, y, style ).rotate( deg, x, y ).raw( text )
      end # _rtext

#      # render text rotated around its position coordinates
#      public
#      def rtext( x, y, deg, text, style )
#        @output << %Q{<text x="#{x}" y="#{y}" transform="rotate(#{deg}, #{x}, #{y})"}
#        style = fix_style(default_style.merge(style))
#        @output << %Q{ font-family="#{style.delete "font-family"}"} if style["font-family"]
#        @output << %Q{ font-size="#{style.delete "font-size"}"} if style["font-size"]
#        write_style style
#        @output << ">"
#        dy = 0      # First line should not be shifted
#        text.each_line do |line|
#          @output << %Q{<tspan x="#{x}" dy="#{dy}em">}
#          dy = 1    # Next lines should be shifted
#          @output << line.rstrip
#          @output << "</tspan>"
#        end
#        @output << "</text>"
#      end
#
      # embed external SVG at specified position
      public
      def import ( path, x, y, w, h, deg = 0 )
        # hack to bypass Inkscape resistance to accept mm units
        @output << %Q{<use x="#{x}" y="#{y}" width="#{w}" height="#{h*2}" xlink:href="#{path}#layer1" transform="rotate(#{deg}, #{x}, #{y})"/>}
      end

    end # Svg

  end #Creat
end # Io

