pdf.font_families.update(
  'Times' => {
    normal:      "#{Rails.root}/app/assets/prawn/fonts/times.ttf",
    bold:        "#{Rails.root}/app/assets/prawn/fonts/timesbd.ttf",
    bold_italic: "#{Rails.root}/app/assets/prawn/fonts/timesbi.ttf",
    italic:      "#{Rails.root}/app/assets/prawn/fonts/timesi.ttf"
  }
)

pdf.text @article.text, inline_format: true