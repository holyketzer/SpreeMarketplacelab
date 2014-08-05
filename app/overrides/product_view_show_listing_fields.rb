Deface::Override.new(
    :name => "listings_section",
    :virtual_path => "spree/products/show",
    :insert_after => "[data-hook='product-description'], #product-description[data-hook]",
    :partial => "shared/listing"
)