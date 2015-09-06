
# vim: et

module Io
  module Creat

    SVG_STYLE = {
      :stroke_width   => 0.11, # mm
      :stroke         => 'black',
      :font_family    => 'Slipstick Sans Mono,Arial,Sans-serif', 
      :font_weight    => 'normal',
      :font_style     => 'normal',
      :fill           => 'black',
      :letter_spacing => -0.15, # em, Inkscape does not support anything else
      :font_size      => 3.0, # mm
      :text_anchor    => 'left',
    }

    SVG_STYLE_LINE = 0;
    SVG_STYLE_TEXT = 1;

    # decorates style with units
    public
    def self.svg_dec_style_units ( style = SVG_STYLE, purpose = SVG_STYLE_LINE )
      raise "Only SVG_STYLE_LINE or SVG_STYLE_TEXT are supported" unless [ SVG_STYLE_LINE, SVG_STYLE_TEXT ].include?( purpose ) 
      copy = style.merge(
      {
        :stroke_width => "%fmm" % style[:stroke_width],
        :letter_spacing => "%gem" % style[:letter_spacing],
      } )
      if purpose == SVG_STYLE_TEXT:
        copy.delete( :stroke_width )
      else # SVG_STYLE_LINE
        return copy.merge( { :fill => 'none' } )
      end
      return copy
    end # svg_dec_style_units

  end # Creat
end # Io

