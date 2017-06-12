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
      end

      # Primitive rendering line with a pattern.
      # TODO fix the default pattern
      public
      def pline( x1, y1, x2, y2, style=DefaultStyles[:line], pattern = "" )
        line( x1, y1, x2, y2, style.merge( { :"stroke-dasharray" => pattern } ) )
      end

      # Primitive mapping the functionality of a simple text output.
      public
      def _text ( x, y, text, style )
        text( x, y, style ) { raw text }
      end # _text

      # Primitive mapping the functionality of a rotated text.
      public
      def _rtext ( x, y, deg, text, style )
        text( x, y, style ).rotate( deg, x, y ).raw( text )
      end # _rtext

      # Embed an external SVG at a specified position.
      public
      def import ( path, x, y, w, h, deg = 0 )
        # hack to bypass Inkscape resistance to accept mm units
        @output << %Q{<use x="#{x}" y="#{y}" width="#{w}" height="#{h*2}" xlink:href="#{path}#layer1" transform="rotate(#{deg}, #{x}, #{y})"/>}
      end

    end # Svg

  end # Creat
end # Io

