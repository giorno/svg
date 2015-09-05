
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
    }

    # decorates style with units
    public
    def svg_dec_style_units ( style = SVG_STYLE )
      return style.merge( { :letter_spacing => "%gem" % style[:letter_spacing] } ) 
    end # svg_dec_style_units

  end # Creat
end # Io
