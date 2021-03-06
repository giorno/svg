
# vim: et

module Io
  module Creat

    SVG_STYLE = {
      :"stroke-width"    => 0.11, # mm
      :stroke           => 'black',
      :"font-family"    => 'Slipstick Sans Mono,Arial,Sans-serif', 
      :"font-weight"    => 'normal',
      :"font-style"     => 'normal',
      :fill             => 'black',
      :"letter-spacing" => -0.15, # em, Inkscape does not support anything else
      :"font-size"      => 3.0, # mm
      :"text-anchor"    => 'left',
    }

    SVG_STYLE_LINE = 1;
    SVG_STYLE_TEXT = 2;

    # decorates style with units
    public
    def self.svg_dec_style_units ( style = SVG_STYLE, purpose = SVG_STYLE_LINE )
      raise "Only SVG_STYLE_LINE or SVG_STYLE_TEXT are supported" unless [ SVG_STYLE_LINE, SVG_STYLE_TEXT ].include?( purpose ) 
      copy = style.merge(
      {
        :"letter-spacing" => "%gem" % style[:"letter-spacing"],
      } )
      if purpose == SVG_STYLE_TEXT
        copy.delete( :stroke )
        copy.delete( :"stroke-width" )
      else # SVG_STYLE_LINE
        return copy.merge( { :fill => 'none' } )
      end
      return copy
    end # svg_dec_style_units

  end # Creat
end # Io

