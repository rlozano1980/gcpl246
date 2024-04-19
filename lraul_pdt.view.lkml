
view: lraul_pdt {
  derived_table: {
    sql: SELECT
          inventory_items.id  AS `inventory_items.id`,
          inventory_items.cost  AS `inventory_items.cost`,
              (DATE(CONVERT_TZ(inventory_items.sold_at ,'UTC','America/New_York'))) AS `inventory_items.sold_date`,
          products.retail_price  AS `products.retail_price`
      FROM demo_db.inventory_items  AS inventory_items
      LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id
      LIMIT 500 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: inventory_items_id {
    type: number
    sql: ${TABLE}.`inventory_items.id` ;;
  }

  dimension: inventory_items_cost {
    type: number
    sql: ${TABLE}.`inventory_items.cost` ;;
  }

  dimension: inventory_items_sold_date {
    type: date
    sql: ${TABLE}.`inventory_items.sold_date` ;;
  }

  dimension: products_retail_price {
    type: number
    sql: ${TABLE}.`products.retail_price` ;;
  }

  set: detail {
    fields: [
        inventory_items_id,
	inventory_items_cost,
	inventory_items_sold_date,
	products_retail_price
    ]
  }
}
