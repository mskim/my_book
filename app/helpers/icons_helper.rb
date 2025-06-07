module IconsHelper
  def icon(name, options = {})
    # This helper is configured to use the Lucide icons library:
    # https://lucide.dev/

    # It relies on the lucide-rails gem:
    # https://github.com/heyvito/lucide-rails

    # Options & defaults:
    size = normalize_size(options[:size]) || 18 # Pass a tailwind text size or integer
    stroke_width = options[:stroke_width] || 2
    use_absolute_stroke_width = options[:use_absolute_stroke_width] || options[:absoluteStrokeWidth] || false
    color = options[:color] # Pass any tailwind color class
    classes = options[:class] || options[:classes] # Pass any additional tailwind classes. If these include text sizes or colors, these will override the size and color options.
    data = options[:data]

    lucide_icon(name,
                size: size.to_s,
                "stroke-width": stroke_width,
                "absoluteStrokeWidth": use_absolute_stroke_width,
                class: "#{color} #{classes}",
                data: data
              )
  end

  private

  def normalize_size(size)
    return nil if size.nil?
    return size if size.is_a?(Integer)
    return nil unless size.is_a?(String) && (size.start_with?('text-'))

    # Handle custom text sizes like text-[14px] or text-[14rem]
    if size.start_with?('text-[')
      # Extract the number from text-[number][unit]
      number = size.match(/text-\[(\d+)/)&.captures&.first
      return number.to_i if number
    end

    # Tailwind text size to pixel mapping
    case size
    when 'text-xs'
      return 12
    when 'text-sm'
      return 14
    when 'text-base'
      return 16
    when 'text-lg'
      return 18
    when 'text-xl'
      return 20
    when 'text-2xl'
      return 24
    when 'text-3xl'
      return 30
    when 'text-4xl'
      return 36
    when 'text-5xl'
      return 48
    when 'text-6xl'
      return 60
    when 'text-7xl'
      return 72
    when 'text-8xl'
      return 96
    when 'text-9xl'
      return 128
    else
      return nil
    end
  end
end
