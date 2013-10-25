CREATE OR REPLACE PACKAGE xx_consignment_solution
AS
   PROCEDURE do_create_ship_to_location (
      p_location_id             OUT NOCOPY      NUMBER
    , p_location_code           IN              VARCHAR2 DEFAULT NULL
    , p_description             IN              VARCHAR2 DEFAULT NULL
    , p_style                   IN              VARCHAR2 DEFAULT NULL
    , p_address_line_1          IN              VARCHAR2 DEFAULT NULL
    , p_address_line_2          IN              VARCHAR2 DEFAULT NULL
    , p_address_line_3          IN              VARCHAR2 DEFAULT NULL
    , p_country                 IN              VARCHAR2 DEFAULT NULL
    , p_postal_code             IN              VARCHAR2 DEFAULT NULL
    , p_region_1                IN              VARCHAR2 DEFAULT NULL
    , p_region_2                IN              VARCHAR2 DEFAULT NULL
    , p_region_3                IN              VARCHAR2 DEFAULT NULL
    , p_town_or_city            IN              VARCHAR2 DEFAULT NULL
    , p_tax_name                IN              VARCHAR2 DEFAULT NULL
    , p_telephone_number_1      IN              VARCHAR2 DEFAULT NULL
    , p_telephone_number_2      IN              VARCHAR2 DEFAULT NULL
    , p_telephone_number_3      IN              VARCHAR2 DEFAULT NULL
    , p_loc_information13       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information14       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information15       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information16       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information17       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information18       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information19       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information20       IN              VARCHAR2 DEFAULT NULL
    , p_attribute_category      IN              VARCHAR2 DEFAULT NULL
    , p_attribute1              IN              VARCHAR2 DEFAULT NULL
    , p_attribute2              IN              VARCHAR2 DEFAULT NULL
    , p_attribute3              IN              VARCHAR2 DEFAULT NULL
    , p_attribute4              IN              VARCHAR2 DEFAULT NULL
    , p_attribute5              IN              VARCHAR2 DEFAULT NULL
    , p_attribute6              IN              VARCHAR2 DEFAULT NULL
    , p_attribute7              IN              VARCHAR2 DEFAULT NULL
    , p_attribute8              IN              VARCHAR2 DEFAULT NULL
    , p_attribute9              IN              VARCHAR2 DEFAULT NULL
    , p_attribute10             IN              VARCHAR2 DEFAULT NULL
    , p_attribute11             IN              VARCHAR2 DEFAULT NULL
    , p_attribute12             IN              VARCHAR2 DEFAULT NULL
    , p_attribute13             IN              VARCHAR2 DEFAULT NULL
    , p_attribute14             IN              VARCHAR2 DEFAULT NULL
    , p_attribute15             IN              VARCHAR2 DEFAULT NULL
    , p_attribute16             IN              VARCHAR2 DEFAULT NULL
    , p_attribute17             IN              VARCHAR2 DEFAULT NULL
    , p_attribute18             IN              VARCHAR2 DEFAULT NULL
    , p_attribute19             IN              VARCHAR2 DEFAULT NULL
    , p_attribute20             IN              VARCHAR2 DEFAULT NULL
    , p_object_version_number   OUT NOCOPY      NUMBER
    , x_return_status           OUT NOCOPY      VARCHAR2
    , x_msg_count               OUT NOCOPY      NUMBER
    , x_msg_data                OUT NOCOPY      VARCHAR2
   );

   PROCEDURE create_hr_location (
      p_order_number    IN              VARCHAR2
    , x_return_status   OUT NOCOPY      VARCHAR2
    , x_msg_count       OUT NOCOPY      NUMBER
    , x_msg_data        OUT NOCOPY      VARCHAR2
   );

   PROCEDURE do_update_site_use (
      p_site_use_id       IN              NUMBER
    , p_primary_flag      IN              VARCHAR2
    , p_status            IN              VARCHAR2
    , p_customer_id       IN              NUMBER
    , p_inv_location_id   IN              NUMBER
    , x_return_status     OUT NOCOPY      VARCHAR2
    , x_msg_count         OUT NOCOPY      NUMBER
    , x_msg_data          OUT NOCOPY      VARCHAR2
   );

   PROCEDURE auto_create_internal_req (p_ord_header_id IN NUMBER, x_return_status OUT NOCOPY VARCHAR2);

   PROCEDURE get_move_order_details (
      p_move_order_number   IN              VARCHAR2
    , x_return_status       OUT NOCOPY      VARCHAR2
    , x_msg_count           OUT NOCOPY      NUMBER
    , x_msg_data            OUT NOCOPY      VARCHAR2
   );

   PROCEDURE create_customer_subinventory (p_site_use_id IN VARCHAR2, p_organization_id IN NUMBER);
END;
/

CREATE OR REPLACE PACKAGE BODY xx_consignment_solution
AS
   PROCEDURE do_create_ship_to_location (
      p_location_id             OUT NOCOPY      NUMBER
    , p_location_code           IN              VARCHAR2 DEFAULT NULL
    , p_description             IN              VARCHAR2 DEFAULT NULL
    , p_style                   IN              VARCHAR2 DEFAULT NULL
    , p_address_line_1          IN              VARCHAR2 DEFAULT NULL
    , p_address_line_2          IN              VARCHAR2 DEFAULT NULL
    , p_address_line_3          IN              VARCHAR2 DEFAULT NULL
    , p_country                 IN              VARCHAR2 DEFAULT NULL
    , p_postal_code             IN              VARCHAR2 DEFAULT NULL
    , p_region_1                IN              VARCHAR2 DEFAULT NULL
    , p_region_2                IN              VARCHAR2 DEFAULT NULL
    , p_region_3                IN              VARCHAR2 DEFAULT NULL
    , p_town_or_city            IN              VARCHAR2 DEFAULT NULL
    , p_tax_name                IN              VARCHAR2 DEFAULT NULL
    , p_telephone_number_1      IN              VARCHAR2 DEFAULT NULL
    , p_telephone_number_2      IN              VARCHAR2 DEFAULT NULL
    , p_telephone_number_3      IN              VARCHAR2 DEFAULT NULL
    , p_loc_information13       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information14       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information15       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information16       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information17       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information18       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information19       IN              VARCHAR2 DEFAULT NULL
    , p_loc_information20       IN              VARCHAR2 DEFAULT NULL
    , p_attribute_category      IN              VARCHAR2 DEFAULT NULL
    , p_attribute1              IN              VARCHAR2 DEFAULT NULL
    , p_attribute2              IN              VARCHAR2 DEFAULT NULL
    , p_attribute3              IN              VARCHAR2 DEFAULT NULL
    , p_attribute4              IN              VARCHAR2 DEFAULT NULL
    , p_attribute5              IN              VARCHAR2 DEFAULT NULL
    , p_attribute6              IN              VARCHAR2 DEFAULT NULL
    , p_attribute7              IN              VARCHAR2 DEFAULT NULL
    , p_attribute8              IN              VARCHAR2 DEFAULT NULL
    , p_attribute9              IN              VARCHAR2 DEFAULT NULL
    , p_attribute10             IN              VARCHAR2 DEFAULT NULL
    , p_attribute11             IN              VARCHAR2 DEFAULT NULL
    , p_attribute12             IN              VARCHAR2 DEFAULT NULL
    , p_attribute13             IN              VARCHAR2 DEFAULT NULL
    , p_attribute14             IN              VARCHAR2 DEFAULT NULL
    , p_attribute15             IN              VARCHAR2 DEFAULT NULL
    , p_attribute16             IN              VARCHAR2 DEFAULT NULL
    , p_attribute17             IN              VARCHAR2 DEFAULT NULL
    , p_attribute18             IN              VARCHAR2 DEFAULT NULL
    , p_attribute19             IN              VARCHAR2 DEFAULT NULL
    , p_attribute20             IN              VARCHAR2 DEFAULT NULL
    , p_object_version_number   OUT NOCOPY      NUMBER
    , x_return_status           OUT NOCOPY      VARCHAR2
    , x_msg_count               OUT NOCOPY      NUMBER
    , x_msg_data                OUT NOCOPY      VARCHAR2
   )
   IS
      l_api_version_number   CONSTANT NUMBER                                            := 1.0;
      l_api_name             CONSTANT VARCHAR2 (30)                                     := 'do_create_ship_to_location';
      excp_user_defined               EXCEPTION;
      l_validate                      BOOLEAN                                           := FALSE;
      l_effective_date                DATE                                              := SYSDATE;
      l_location_id                   hr_locations_all.location_id%TYPE;
      l_language                      hr_locations_all_tl.LANGUAGE%TYPE;
      l_location_code                 hr_locations_all.location_code%TYPE               := NULL;
      l_description                   hr_locations_all.description%TYPE                 := NULL;
      l_bill_to_site_flag             hr_locations_all.bill_to_site_flag%TYPE           := 'Y';
      l_ship_to_site_flag             hr_locations_all.ship_to_site_flag%TYPE           := 'Y';
      l_tp_header_id                  hr_locations_all.tp_header_id%TYPE                := NULL;
      l_ece_tp_location_code          hr_locations_all.ece_tp_location_code%TYPE        := NULL;
      l_designated_receiver_id        hr_locations_all.designated_receiver_id%TYPE      := NULL;
      l_in_organization_flag          hr_locations_all.in_organization_flag%TYPE        := 'Y';
      l_inactive_date                 hr_locations_all.inactive_date%TYPE               := NULL;
      l_operating_unit_id             NUMBER                                            := NULL;
      l_inventory_organization_id     hr_locations_all.inventory_organization_id%TYPE   := NULL;
      l_office_site_flag              hr_locations_all.office_site_flag%TYPE            := 'Y';
      l_receiving_site_flag           hr_locations_all.receiving_site_flag%TYPE         := 'Y';
      l_ship_to_location_id           hr_locations_all.ship_to_location_id%TYPE         := NULL;
      g_pkg_name                      VARCHAR2 (30)                                     := 'do_create_hr_location';
   BEGIN
      SAVEPOINT do_create_ship_to_location_pub;
      -- Initialize
      x_return_status := fnd_api.g_ret_sts_success;

      SELECT USERENV ('LANG')
        INTO l_language
        FROM DUAL;

      hr_location_api.create_location (p_effective_date                 => l_effective_date
                                     , p_location_code                  => p_location_code
                                     , p_description                    => p_description
                                     , p_tp_header_id                   => l_tp_header_id
                                     , p_ece_tp_location_code           => l_ece_tp_location_code
                                     , p_address_line_1                 => p_address_line_1
                                     , p_address_line_2                 => p_address_line_2
                                     , p_address_line_3                 => p_address_line_3
                                     , p_bill_to_site_flag              => l_bill_to_site_flag
                                     , p_country                        => p_country
                                     , p_designated_receiver_id         => l_designated_receiver_id
                                     , p_in_organization_flag           => l_in_organization_flag
                                     , p_inactive_date                  => l_inactive_date
                                     , p_operating_unit_id              => l_operating_unit_id
                                     , p_inventory_organization_id      => l_inventory_organization_id
                                     , p_office_site_flag               => l_office_site_flag
                                     , p_postal_code                    => p_postal_code
                                     , p_receiving_site_flag            => l_receiving_site_flag
                                     , p_region_1                       => p_region_1
                                     , p_region_2                       => p_region_2
                                     , p_region_3                       => p_region_3
                                     , p_ship_to_location_id            => l_ship_to_location_id
                                     , p_ship_to_site_flag              => l_ship_to_site_flag
                                     , p_style                          => p_style
                                     , p_tax_name                       => p_tax_name
                                     , p_telephone_number_1             => p_telephone_number_1
                                     , p_telephone_number_2             => p_telephone_number_2
                                     , p_telephone_number_3             => p_telephone_number_3
                                     , p_town_or_city                   => p_town_or_city
                                     , p_loc_information13              => p_loc_information13
                                     , p_loc_information14              => p_loc_information14
                                     , p_loc_information15              => p_loc_information15
                                     , p_loc_information16              => p_loc_information16
                                     , p_loc_information17              => p_loc_information17
                                     , p_loc_information18              => p_loc_information18
                                     , p_loc_information19              => p_loc_information19
                                     , p_loc_information20              => p_loc_information20
                                     , p_location_id                    => p_location_id
                                     , p_object_version_number          => p_object_version_number
                                     , p_attribute1                     => p_attribute1
                                     , p_attribute2                     => p_attribute2
                                     , p_attribute3                     => p_attribute3
                                     , p_attribute4                     => p_attribute4
                                     , p_attribute5                     => p_attribute5
                                     , p_attribute6                     => p_attribute6
                                     , p_attribute7                     => p_attribute7
                                     , p_attribute8                     => p_attribute8
                                     , p_attribute9                     => p_attribute9
                                     , p_attribute10                    => p_attribute10
                                     , p_attribute11                    => p_attribute11
                                     , p_attribute12                    => p_attribute12
                                     , p_attribute13                    => p_attribute13
                                     , p_attribute14                    => p_attribute14
                                     , p_attribute15                    => p_attribute15
                                     , p_attribute16                    => p_attribute16
                                     , p_attribute17                    => p_attribute17
                                     , p_attribute18                    => p_attribute18
                                     , p_attribute19                    => p_attribute19
                                     , p_attribute20                    => p_attribute20
                                     , p_attribute_category             => p_attribute_category
                                      );
      fnd_msg_pub.count_and_get (p_count => x_msg_count, p_data => x_msg_data);
-- Exception Block
   EXCEPTION
      WHEN excp_user_defined
      THEN
         ROLLBACK TO do_create_ship_to_location_pub;
         x_return_status := fnd_api.g_ret_sts_error;
         jtf_plsql_api.handle_exceptions (p_api_name             => l_api_name
                                        , p_pkg_name             => g_pkg_name
                                        , p_exception_level      => fnd_msg_pub.g_msg_lvl_error
                                        , p_package_type         => jtf_plsql_api.g_pub
                                        , x_msg_count            => x_msg_count
                                        , x_msg_data             => x_msg_data
                                        , x_return_status        => x_return_status
                                         );
      WHEN fnd_api.g_exc_error
      THEN
         jtf_plsql_api.handle_exceptions (p_api_name             => l_api_name
                                        , p_pkg_name             => g_pkg_name
                                        , p_exception_level      => fnd_msg_pub.g_msg_lvl_error
                                        , p_package_type         => jtf_plsql_api.g_pub
                                        , x_msg_count            => x_msg_count
                                        , x_msg_data             => x_msg_data
                                        , x_return_status        => x_return_status
                                         );
      WHEN fnd_api.g_exc_unexpected_error
      THEN
         jtf_plsql_api.handle_exceptions (p_api_name             => l_api_name
                                        , p_pkg_name             => g_pkg_name
                                        , p_exception_level      => fnd_msg_pub.g_msg_lvl_error
                                        , p_package_type         => jtf_plsql_api.g_pub
                                        , x_msg_count            => x_msg_count
                                        , x_msg_data             => x_msg_data
                                        , x_return_status        => x_return_status
                                         );
      WHEN OTHERS
      THEN
         ROLLBACK TO do_create_ship_to_location_pub;
         fnd_message.set_name ('CSP', 'CSP_UNEXPECTED_EXEC_ERRORS');
         fnd_message.set_token ('ROUTINE', l_api_name, FALSE);
         fnd_message.set_token ('SQLERRM', SQLERRM, FALSE);
         fnd_msg_pub.ADD;
         fnd_msg_pub.count_and_get (p_count => x_msg_count, p_data => x_msg_data);
         x_return_status := fnd_api.g_ret_sts_error;
   END do_create_ship_to_location;

   PROCEDURE create_hr_location (
      p_order_number    IN              VARCHAR2
    , x_return_status   OUT NOCOPY      VARCHAR2
    , x_msg_count       OUT NOCOPY      NUMBER
    , x_msg_data        OUT NOCOPY      VARCHAR2
   )
   IS
      l_party_name         VARCHAR2 (100);
      l_location_code      VARCHAR2 (30);
      l_address_line_1     VARCHAR2 (100);
      l_address_line_2     VARCHAR2 (100);
      l_address_line_3     VARCHAR2 (100);
      l_town_or_city       VARCHAR2 (100);
      l_state              VARCHAR2 (100);
      l_postal_code        VARCHAR2 (100);
      l_country            VARCHAR2 (100);
      x_location_id        NUMBER;
      x_obj_ver_number     NUMBER;
      l_ship_site_use_id   NUMBER;
   BEGIN
      SELECT ship_to_org_id
        INTO l_ship_site_use_id
        FROM oe_order_headers
       WHERE order_number = p_order_number;

      SELECT e.party_name, account_number || '-' || party_site_number location_code, address_line_1, address_line_2
           , address_line_3, a.town_or_city, a.state, a.postal_code, a.country
        INTO l_party_name, l_location_code, l_address_line_1, l_address_line_2
           , l_address_line_3, l_town_or_city, l_state, l_postal_code, l_country
        FROM oe_ship_to_orgs_v a, hz_cust_accounts b, hz_cust_acct_sites_all c, hz_party_sites d, hz_parties e
       WHERE organization_id = l_ship_site_use_id
         AND a.address_id = c.cust_acct_site_id
         AND b.cust_account_id = c.cust_account_id
         AND c.party_site_id = d.party_site_id
         AND d.party_id = e.party_id;

      do_create_ship_to_location (p_location_id                => x_location_id
                                , p_style                      => 'US_GLB'
                                , p_address_line_1             => l_address_line_1
                                , p_address_line_2             => l_address_line_2
                                , p_address_line_3             => l_address_line_3
                                , p_town_or_city               => l_town_or_city
                                , p_region_2                   => l_state
                                , p_country                    => l_country
                                , p_postal_code                => l_postal_code
                                , p_location_code              => l_location_code
                                , p_description                => l_party_name
                                , x_return_status              => x_return_status
                                , x_msg_count                  => x_msg_count
                                , x_msg_data                   => x_msg_data
                                , p_object_version_number      => x_obj_ver_number
                                 );
   END;

   PROCEDURE do_update_site_use (
      p_site_use_id       IN              NUMBER
    , p_primary_flag      IN              VARCHAR2
    , p_status            IN              VARCHAR2
    , p_customer_id       IN              NUMBER
    , p_inv_location_id   IN              NUMBER
    , x_return_status     OUT NOCOPY      VARCHAR2
    , x_msg_count         OUT NOCOPY      NUMBER
    , x_msg_data          OUT NOCOPY      VARCHAR2
   )
   IS
      l_api_version_number    CONSTANT NUMBER                                                      := 1.0;
      l_api_name              CONSTANT VARCHAR2 (30)                                               := 'do_update_site_use';
      l_language                       VARCHAR2 (4);
      excp_user_defined                EXCEPTION;
      l_site_use_id                    hz_cust_site_uses_all.site_use_id%TYPE;
      s_cust_acct_site_id              hz_cust_site_uses_all.cust_acct_site_id%TYPE;
      s_creation_date                  hz_cust_site_uses_all.creation_date%TYPE;
      s_created_by                     hz_cust_site_uses_all.created_by%TYPE;
      s_site_use_code                  hz_cust_site_uses_all.site_use_code%TYPE;
      s_primary_flag                   hz_cust_site_uses_all.primary_flag%TYPE;
      s_status                         hz_cust_site_uses_all.status%TYPE;
      s_location                       hz_cust_site_uses_all.LOCATION%TYPE;
      s_last_update_login              hz_cust_site_uses_all.last_update_login%TYPE;
      s_contact_id                     hz_cust_site_uses_all.contact_id%TYPE;
      s_bill_to_site_use_id            hz_cust_site_uses_all.bill_to_site_use_id%TYPE;
      s_orig_system_reference          hz_cust_site_uses_all.orig_system_reference%TYPE;
      s_sic_code                       hz_cust_site_uses_all.sic_code%TYPE;
      s_payment_term_id                hz_cust_site_uses_all.payment_term_id%TYPE;
      s_gsa_indicator                  hz_cust_site_uses_all.gsa_indicator%TYPE;
      s_ship_partial                   hz_cust_site_uses_all.ship_partial%TYPE;
      s_ship_via                       hz_cust_site_uses_all.ship_via%TYPE;
      s_fob_point                      hz_cust_site_uses_all.fob_point%TYPE;
      s_order_type_id                  hz_cust_site_uses_all.order_type_id%TYPE;
      s_price_list_id                  hz_cust_site_uses_all.price_list_id%TYPE;
      s_freight_term                   hz_cust_site_uses_all.freight_term%TYPE;
      s_warehouse_id                   hz_cust_site_uses_all.warehouse_id%TYPE;
      s_territory_id                   hz_cust_site_uses_all.territory_id%TYPE;
      s_attribute_category             hz_cust_site_uses_all.attribute_category%TYPE;
      s_attribute1                     hz_cust_site_uses_all.attribute1%TYPE;
      s_attribute2                     hz_cust_site_uses_all.attribute2%TYPE;
      s_attribute3                     hz_cust_site_uses_all.attribute3%TYPE;
      s_attribute4                     hz_cust_site_uses_all.attribute4%TYPE;
      s_attribute5                     hz_cust_site_uses_all.attribute5%TYPE;
      s_attribute6                     hz_cust_site_uses_all.attribute6%TYPE;
      s_attribute7                     hz_cust_site_uses_all.attribute7%TYPE;
      s_attribute8                     hz_cust_site_uses_all.attribute8%TYPE;
      s_attribute9                     hz_cust_site_uses_all.attribute9%TYPE;
      s_attribute10                    hz_cust_site_uses_all.attribute10%TYPE;
      s_request_id                     hz_cust_site_uses_all.request_id%TYPE;
      s_program_application_id         hz_cust_site_uses_all.program_application_id%TYPE;
      s_program_id                     hz_cust_site_uses_all.program_id%TYPE;
      s_program_update_date            hz_cust_site_uses_all.program_update_date%TYPE;
      s_tax_reference                  hz_cust_site_uses_all.tax_reference%TYPE;
      s_sort_priority                  hz_cust_site_uses_all.sort_priority%TYPE;
      s_tax_code                       hz_cust_site_uses_all.tax_code%TYPE;
      s_attribute11                    hz_cust_site_uses_all.attribute11%TYPE;
      s_attribute12                    hz_cust_site_uses_all.attribute12%TYPE;
      s_attribute13                    hz_cust_site_uses_all.attribute13%TYPE;
      s_attribute14                    hz_cust_site_uses_all.attribute14%TYPE;
      s_attribute15                    hz_cust_site_uses_all.attribute15%TYPE;
      s_attribute16                    hz_cust_site_uses_all.attribute16%TYPE;
      s_attribute17                    hz_cust_site_uses_all.attribute17%TYPE;
      s_attribute18                    hz_cust_site_uses_all.attribute18%TYPE;
      s_attribute19                    hz_cust_site_uses_all.attribute19%TYPE;
      s_attribute20                    hz_cust_site_uses_all.attribute20%TYPE;
      s_attribute21                    hz_cust_site_uses_all.attribute21%TYPE;
      s_attribute22                    hz_cust_site_uses_all.attribute22%TYPE;
      s_attribute23                    hz_cust_site_uses_all.attribute23%TYPE;
      s_attribute24                    hz_cust_site_uses_all.attribute24%TYPE;
      s_attribute25                    hz_cust_site_uses_all.attribute25%TYPE;
      s_last_accrue_charge_date        DATE;
      s_snd_last_accrue_charge_date    DATE;
      s_last_unaccrue_charge_date      DATE;
      s_snd_last_unaccrue_chrg_date    DATE;
      s_demand_class_code              hz_cust_site_uses_all.demand_class_code%TYPE;
      s_org_id                         hz_cust_site_uses_all.org_id%TYPE;
      s_tax_header_level_flag          hz_cust_site_uses_all.tax_header_level_flag%TYPE;
      s_tax_rounding_rule              hz_cust_site_uses_all.tax_rounding_rule%TYPE;
      s_wh_update_date                 hz_cust_site_uses_all.wh_update_date%TYPE;
      s_global_attribute1              hz_cust_site_uses_all.global_attribute1%TYPE;
      s_global_attribute2              hz_cust_site_uses_all.global_attribute2%TYPE;
      s_global_attribute3              hz_cust_site_uses_all.global_attribute3%TYPE;
      s_global_attribute4              hz_cust_site_uses_all.global_attribute4%TYPE;
      s_global_attribute5              hz_cust_site_uses_all.global_attribute5%TYPE;
      s_global_attribute6              hz_cust_site_uses_all.global_attribute6%TYPE;
      s_global_attribute7              hz_cust_site_uses_all.global_attribute7%TYPE;
      s_global_attribute8              hz_cust_site_uses_all.global_attribute8%TYPE;
      s_global_attribute9              hz_cust_site_uses_all.global_attribute9%TYPE;
      s_global_attribute10             hz_cust_site_uses_all.global_attribute10%TYPE;
      s_global_attribute11             hz_cust_site_uses_all.global_attribute11%TYPE;
      s_global_attribute12             hz_cust_site_uses_all.global_attribute12%TYPE;
      s_global_attribute13             hz_cust_site_uses_all.global_attribute13%TYPE;
      s_global_attribute14             hz_cust_site_uses_all.global_attribute14%TYPE;
      s_global_attribute15             hz_cust_site_uses_all.global_attribute15%TYPE;
      s_global_attribute16             hz_cust_site_uses_all.global_attribute16%TYPE;
      s_global_attribute17             hz_cust_site_uses_all.global_attribute17%TYPE;
      s_global_attribute18             hz_cust_site_uses_all.global_attribute18%TYPE;
      s_global_attribute19             hz_cust_site_uses_all.global_attribute19%TYPE;
      s_global_attribute20             hz_cust_site_uses_all.global_attribute20%TYPE;
      s_global_attribute_category      hz_cust_site_uses_all.global_attribute_category%TYPE;
      s_primary_salesrep_id            hz_cust_site_uses_all.primary_salesrep_id%TYPE;
      s_finchrg_receivables_trx_id     hz_cust_site_uses_all.finchrg_receivables_trx_id%TYPE;
      s_dates_negative_tolerance       hz_cust_site_uses_all.dates_negative_tolerance%TYPE;
      s_dates_positive_tolerance       hz_cust_site_uses_all.dates_positive_tolerance%TYPE;
      s_date_type_preference           hz_cust_site_uses_all.date_type_preference%TYPE;
      s_over_shipment_tolerance        hz_cust_site_uses_all.over_shipment_tolerance%TYPE;
      s_under_shipment_tolerance       hz_cust_site_uses_all.under_shipment_tolerance%TYPE;
      s_item_cross_ref_pref            hz_cust_site_uses_all.item_cross_ref_pref%TYPE;
      s_over_return_tolerance          hz_cust_site_uses_all.over_return_tolerance%TYPE;
      s_under_return_tolerance         hz_cust_site_uses_all.under_return_tolerance%TYPE;
      s_ship_sets_include_lines_flag   hz_cust_site_uses_all.ship_sets_include_lines_flag%TYPE;
      s_arv_include_lines_flag         hz_cust_site_uses_all.arrivalsets_include_lines_flag%TYPE;
      s_sched_date_push_flag           hz_cust_site_uses_all.sched_date_push_flag%TYPE;
      s_invoice_quantity_rule          hz_cust_site_uses_all.invoice_quantity_rule%TYPE;
      s_pricing_event                  hz_cust_site_uses_all.pricing_event%TYPE;
      s_gl_id_rec                      hz_cust_site_uses_all.gl_id_rec%TYPE;
      s_gl_id_rev                      hz_cust_site_uses_all.gl_id_rev%TYPE;
      s_gl_id_tax                      hz_cust_site_uses_all.gl_id_tax%TYPE;
      s_gl_id_freight                  hz_cust_site_uses_all.gl_id_freight%TYPE;
      s_gl_id_clearing                 hz_cust_site_uses_all.gl_id_clearing%TYPE;
      s_gl_id_unbilled                 hz_cust_site_uses_all.gl_id_unbilled%TYPE;
      s_gl_id_unearned                 hz_cust_site_uses_all.gl_id_unearned%TYPE;
      s_gl_id_unpaid_rec               hz_cust_site_uses_all.gl_id_unpaid_rec%TYPE;
      s_gl_id_remittance               hz_cust_site_uses_all.gl_id_remittance%TYPE;
      s_gl_id_factor                   hz_cust_site_uses_all.gl_id_factor%TYPE;
      s_tax_classification             hz_cust_site_uses_all.tax_classification%TYPE;
      s_last_update_date               DATE;
      s_last_updated_by                NUMBER;
      g_pkg_name                       VARCHAR2 (30)                                               := 'do_update_site_use_id';

      CURSOR l_cust_site_use_csr
      IS
         SELECT cust_acct_site_id, last_update_date, last_updated_by, creation_date, created_by, site_use_code, primary_flag
              , status, LOCATION, last_update_login, contact_id, bill_to_site_use_id, orig_system_reference, sic_code
              , payment_term_id, gsa_indicator, ship_partial, ship_via, fob_point, order_type_id, price_list_id, freight_term
              , warehouse_id, territory_id, attribute_category, attribute1, attribute2, attribute3, attribute4, attribute5
              , attribute6, attribute7, attribute8, attribute9, attribute10, request_id, program_application_id, program_id
              , program_update_date, tax_reference, sort_priority, tax_code, attribute11, attribute12, attribute13, attribute14
              , attribute15, attribute16, attribute17, attribute18, attribute19, attribute20, attribute21, attribute22
              , attribute23, attribute24, attribute25, last_accrue_charge_date, second_last_accrue_charge_date
              , last_unaccrue_charge_date, second_last_unaccrue_chrg_date, demand_class_code, org_id, tax_header_level_flag
              , tax_rounding_rule, wh_update_date, global_attribute1, global_attribute2, global_attribute3, global_attribute4
              , global_attribute5, global_attribute6, global_attribute7, global_attribute8, global_attribute9
              , global_attribute10, global_attribute11, global_attribute12, global_attribute13, global_attribute14
              , global_attribute15, global_attribute16, global_attribute17, global_attribute18, global_attribute19
              , global_attribute20, global_attribute_category, primary_salesrep_id, finchrg_receivables_trx_id
              , dates_negative_tolerance, dates_positive_tolerance, date_type_preference, over_shipment_tolerance
              , under_shipment_tolerance, item_cross_ref_pref, over_return_tolerance, under_return_tolerance
              , ship_sets_include_lines_flag, arrivalsets_include_lines_flag, sched_date_push_flag, invoice_quantity_rule
              , pricing_event, gl_id_rec, gl_id_rev, gl_id_tax, gl_id_freight, gl_id_clearing, gl_id_unbilled, gl_id_unearned
              , gl_id_unpaid_rec, gl_id_remittance, gl_id_factor, tax_classification
           --from hz_cust_site_uses_all
         FROM   hz_cust_site_uses
          WHERE site_use_id = p_site_use_id AND site_use_code = 'SHIP_TO';
   BEGIN
      SAVEPOINT do_update_site_use_pub;
      l_site_use_id := p_site_use_id;

      OPEN l_cust_site_use_csr;

      FETCH l_cust_site_use_csr
       INTO s_cust_acct_site_id, s_last_update_date, s_last_updated_by, s_creation_date, s_created_by, s_site_use_code
          , s_primary_flag, s_status, s_location, s_last_update_login, s_contact_id, s_bill_to_site_use_id
          , s_orig_system_reference, s_sic_code, s_payment_term_id, s_gsa_indicator, s_ship_partial, s_ship_via, s_fob_point
          , s_order_type_id, s_price_list_id, s_freight_term, s_warehouse_id, s_territory_id, s_attribute_category, s_attribute1
          , s_attribute2, s_attribute3, s_attribute4, s_attribute5, s_attribute6, s_attribute7, s_attribute8, s_attribute9
          , s_attribute10, s_request_id, s_program_application_id, s_program_id, s_program_update_date, s_tax_reference
          , s_sort_priority, s_tax_code, s_attribute11, s_attribute12, s_attribute13, s_attribute14, s_attribute15
          , s_attribute16, s_attribute17, s_attribute18, s_attribute19, s_attribute20, s_attribute21, s_attribute22
          , s_attribute23, s_attribute24, s_attribute25, s_last_accrue_charge_date, s_snd_last_accrue_charge_date
          , s_last_unaccrue_charge_date, s_snd_last_unaccrue_chrg_date, s_demand_class_code, s_org_id, s_tax_header_level_flag
          , s_tax_rounding_rule, s_wh_update_date, s_global_attribute1, s_global_attribute2, s_global_attribute3
          , s_global_attribute4, s_global_attribute5, s_global_attribute6, s_global_attribute7, s_global_attribute8
          , s_global_attribute9, s_global_attribute10, s_global_attribute11, s_global_attribute12, s_global_attribute13
          , s_global_attribute14, s_global_attribute15, s_global_attribute16, s_global_attribute17, s_global_attribute18
          , s_global_attribute19, s_global_attribute20, s_global_attribute_category, s_primary_salesrep_id
          , s_finchrg_receivables_trx_id, s_dates_negative_tolerance, s_dates_positive_tolerance, s_date_type_preference
          , s_over_shipment_tolerance, s_under_shipment_tolerance, s_item_cross_ref_pref, s_over_return_tolerance
          , s_under_return_tolerance, s_ship_sets_include_lines_flag, s_arv_include_lines_flag, s_sched_date_push_flag
          , s_invoice_quantity_rule, s_pricing_event, s_gl_id_rec, s_gl_id_rev, s_gl_id_tax, s_gl_id_freight, s_gl_id_clearing
          , s_gl_id_unbilled, s_gl_id_unearned, s_gl_id_unpaid_rec, s_gl_id_remittance, s_gl_id_factor, s_tax_classification;

      IF l_cust_site_use_csr%FOUND
      THEN
         CLOSE l_cust_site_use_csr;

         -- Update site use
         arh_csu_pkg.update_row (x_site_use_id                       => l_site_use_id
                               , x_last_update_date                  => s_last_update_date
                               , x_last_updated_by                   => NVL (fnd_global.user_id, 1)
                               , x_site_use_code                     => s_site_use_code
                               , x_customer_id                       => p_customer_id
                               , x_address_id                        => s_cust_acct_site_id
                               , x_primary_flag                      => p_primary_flag
                               , x_status                            => p_status
                               , x_location                          => s_location
                               , x_last_update_login                 => s_last_update_login
                               , x_contact_id                        => s_contact_id
                               , x_bill_to_site_use_id               => s_bill_to_site_use_id
                               , x_sic_code                          => s_sic_code
                               , x_payment_term_id                   => s_payment_term_id
                               , x_gsa_indicator                     => s_gsa_indicator
                               , x_ship_partial                      => s_ship_partial
                               , x_ship_via                          => s_ship_via
                               , x_fob_point                         => s_fob_point
                               , x_order_type_id                     => s_order_type_id
                               , x_price_list_id                     => s_price_list_id
                               , x_freight_term                      => s_freight_term
                               , x_warehouse_id                      => s_warehouse_id
                               , x_territory_id                      => s_territory_id
                               , x_tax_code                          => s_tax_code
                               , x_tax_reference                     => s_tax_reference
                               , x_demand_class_code                 => s_demand_class_code
                               , x_inventory_location_id             => p_inv_location_id
                               , x_inventory_organization_id         => s_org_id
                               , x_attribute_category                => s_attribute_category
                               , x_attribute1                        => s_attribute1
                               , x_attribute2                        => s_attribute2
                               , x_attribute3                        => s_attribute3
                               , x_attribute4                        => s_attribute4
                               , x_attribute5                        => s_attribute5
                               , x_attribute6                        => s_attribute6
                               , x_attribute7                        => s_attribute7
                               , x_attribute8                        => s_attribute8
                               , x_attribute9                        => s_attribute9
                               , x_attribute10                       => s_attribute10
                               , x_attribute11                       => s_attribute11
                               , x_attribute12                       => s_attribute12
                               , x_attribute13                       => s_attribute13
                               , x_attribute14                       => s_attribute14
                               , x_attribute15                       => s_attribute15
                               , x_attribute16                       => s_attribute16
                               , x_attribute17                       => s_attribute17
                               , x_attribute18                       => s_attribute18
                               , x_attribute19                       => s_attribute19
                               , x_attribute20                       => s_attribute20
                               , x_attribute21                       => s_attribute21
                               , x_attribute22                       => s_attribute22
                               , x_attribute23                       => s_attribute23
                               , x_attribute24                       => s_attribute24
                               , x_attribute25                       => s_attribute25
                               , x_tax_classification                => s_tax_classification
                               , x_tax_header_level_flag             => s_tax_header_level_flag
                               , x_tax_rounding_rule                 => s_tax_rounding_rule
                               , x_global_attribute_category         => s_global_attribute_category
                               , x_global_attribute1                 => s_global_attribute1
                               , x_global_attribute2                 => s_global_attribute2
                               , x_global_attribute3                 => s_global_attribute3
                               , x_global_attribute4                 => s_global_attribute4
                               , x_global_attribute5                 => s_global_attribute5
                               , x_global_attribute6                 => s_global_attribute6
                               , x_global_attribute7                 => s_global_attribute7
                               , x_global_attribute8                 => s_global_attribute8
                               , x_global_attribute9                 => s_global_attribute9
                               , x_global_attribute10                => s_global_attribute10
                               , x_global_attribute11                => s_global_attribute11
                               , x_global_attribute12                => s_global_attribute12
                               , x_global_attribute13                => s_global_attribute13
                               , x_global_attribute14                => s_global_attribute14
                               , x_global_attribute15                => s_global_attribute15
                               , x_global_attribute16                => s_global_attribute16
                               , x_global_attribute17                => s_global_attribute17
                               , x_global_attribute18                => s_global_attribute18
                               , x_global_attribute19                => s_global_attribute19
                               , x_global_attribute20                => s_global_attribute20
                               , x_primary_salesrep_id               => s_primary_salesrep_id
                               , x_finchrg_receivables_trx_id        => s_finchrg_receivables_trx_id
                               , x_gl_id_rec                         => s_gl_id_rec
                               , x_gl_id_rev                         => s_gl_id_rev
                               , x_gl_id_tax                         => s_gl_id_tax
                               , x_gl_id_freight                     => s_gl_id_freight
                               , x_gl_id_clearing                    => s_gl_id_clearing
                               , x_gl_id_unbilled                    => s_gl_id_unbilled
                               , x_gl_id_unearned                    => s_gl_id_unearned
                               , x_gl_id_unpaid_rec                  => s_gl_id_unpaid_rec
                               , x_gl_id_remittance                  => s_gl_id_remittance
                               , x_gl_id_factor                      => s_gl_id_factor
                               , x_dates_negative_tolerance          => s_dates_negative_tolerance
                               , x_dates_positive_tolerance          => s_dates_positive_tolerance
                               , x_date_type_preference              => s_date_type_preference
                               , x_over_shipment_tolerance           => s_over_shipment_tolerance
                               , x_under_shipment_tolerance          => s_under_shipment_tolerance
                               , x_item_cross_ref_pref               => s_item_cross_ref_pref
                               , x_over_return_tolerance             => s_over_return_tolerance
                               , x_under_return_tolerance            => s_under_return_tolerance
                               , x_ship_sets_include_lines_flag      => s_ship_sets_include_lines_flag
                               , x_arrivalsets_incl_lines_flag       => s_arv_include_lines_flag
                               , x_sched_date_push_flag              => s_sched_date_push_flag
                               , x_invoice_quantity_rule             => s_invoice_quantity_rule
                               , x_msg_count                         => x_msg_count
                               , x_msg_data                          => x_msg_data
                               , x_return_status                     => x_return_status
                                );

         IF x_return_status <> fnd_api.g_ret_sts_success
         THEN
            ROLLBACK TO do_update_site_use_pub;
            /* FND_MESSAGE.SET_NAME ('CSP', 'CSP_SITE_USE_API_ERROR');
             FND_MESSAGE.SET_TOKEN ('TEXT', x_msg_data);
             FND_MSG_PUB.ADD;*/
            RAISE excp_user_defined;
         END IF;
      ELSE
         CLOSE l_cust_site_use_csr;
      END IF;
-- Exception Block
   EXCEPTION
      WHEN excp_user_defined
      THEN
         ROLLBACK TO do_update_site_use_pub;
         x_return_status := fnd_api.g_ret_sts_error;
         jtf_plsql_api.handle_exceptions (p_api_name             => l_api_name
                                        , p_pkg_name             => g_pkg_name
                                        , p_exception_level      => fnd_msg_pub.g_msg_lvl_error
                                        , p_package_type         => jtf_plsql_api.g_pub
                                        , x_msg_count            => x_msg_count
                                        , x_msg_data             => x_msg_data
                                        , x_return_status        => x_return_status
                                         );
      WHEN fnd_api.g_exc_error
      THEN
         jtf_plsql_api.handle_exceptions (p_api_name             => l_api_name
                                        , p_pkg_name             => g_pkg_name
                                        , p_exception_level      => fnd_msg_pub.g_msg_lvl_error
                                        , p_package_type         => jtf_plsql_api.g_pub
                                        , x_msg_count            => x_msg_count
                                        , x_msg_data             => x_msg_data
                                        , x_return_status        => x_return_status
                                         );
      WHEN fnd_api.g_exc_unexpected_error
      THEN
         jtf_plsql_api.handle_exceptions (p_api_name             => l_api_name
                                        , p_pkg_name             => g_pkg_name
                                        , p_exception_level      => fnd_msg_pub.g_msg_lvl_error
                                        , p_package_type         => jtf_plsql_api.g_pub
                                        , x_msg_count            => x_msg_count
                                        , x_msg_data             => x_msg_data
                                        , x_return_status        => x_return_status
                                         );
      WHEN OTHERS
      THEN
         ROLLBACK TO do_update_site_use_pub;
         fnd_message.set_name ('CSP', 'CSP_UNEXPECTED_EXEC_ERRORS');
         fnd_message.set_token ('ROUTINE', l_api_name, TRUE);
         fnd_message.set_token ('SQLERRM', SQLERRM, TRUE);
         fnd_msg_pub.ADD;
         fnd_msg_pub.count_and_get (p_count => x_msg_count, p_data => x_msg_data);
         x_return_status := fnd_api.g_ret_sts_error;
   END do_update_site_use;

   PROCEDURE auto_create_internal_req (p_ord_header_id IN NUMBER, x_return_status OUT NOCOPY VARCHAR2)
   IS
/*
**  PROGRAM LOGIC
**--Query Order Header
**--Query Order Line
**--Derive Values not available on the Internal Sales Order
**--Pass the Internal Sales Order Header values to the internal req header record
**--Pass the Internal Sales Order Line values to the internal req Line table
**--Call the Purchasing API and pass the internal req header record and line tables to Create the Internal Req
**--Check return status of the Purchasing API
**--Update the Internal Sales Order with the Req header id, Req line Ids, Req number and line numbers.
**--Check for return status
**--Handle Exceptions
 */
      l_int_req_ret_sts      VARCHAR2 (1);
      l_req_header_rec       po_create_requisition_sv.header_rec_type;
      l_req_line_tbl         po_create_requisition_sv.line_tbl_type;
      l_created_by           NUMBER;
      l_org_id               NUMBER;
      l_preparer_id          NUMBER;
      l_destination_org_id   NUMBER;
      l_deliver_to_locn_id   NUMBER;
      l_msg_count            NUMBER;
      l_msg_data             VARCHAR2 (2000);
      k                      NUMBER                                   := 0;
      j                      NUMBER                                   := 0;
      v_msg_index_out        NUMBER;
      g_pkg_name             VARCHAR2 (30)                            := 'auto_create_internal_req';

      CURSOR ord_hdr_cur (p_header_id IN NUMBER)
      IS
         SELECT created_by, org_id
           FROM oe_order_headers
          WHERE header_id = p_header_id;

      CURSOR ord_line_cur (p_header_id IN NUMBER)
      IS
         SELECT line_id, order_quantity_uom, ordered_quantity, ship_to_org_id, inventory_item_id, schedule_ship_date, org_id
              , ship_from_org_id, subinventory, source_document_id, source_document_line_id, item_type_code
           FROM oe_order_lines
          WHERE header_id = p_header_id;

      CURSOR employee_id_cur (p_user_id IN NUMBER)
      IS
         SELECT employee_id
           FROM fnd_user
          WHERE user_id = p_user_id;

      CURSOR dest_org_locn_cur (p_cust_id IN NUMBER)
      IS
         SELECT b.location_id, b.organization_id
           FROM oe_ship_to_orgs_v a, po_location_associations b
          WHERE a.organization_id = b.site_use_id AND a.organization_id = p_cust_id;
   BEGIN
      oe_debug_pub.ADD (' Entering procedure auto_create_internal_req ', 2);
      x_return_status := fnd_api.g_ret_sts_success;

--Query Order Header
      OPEN ord_hdr_cur (p_ord_header_id);

      FETCH ord_hdr_cur
       INTO l_created_by, l_org_id;

      CLOSE ord_hdr_cur;

      oe_debug_pub.ADD ('auto_create_internal_req after hdr query ', 2);

--Derive Values not available on the Internal Sales Order
   --Derive the Preparer_id
      BEGIN
         OPEN employee_id_cur (l_created_by);

         FETCH employee_id_cur
          INTO l_preparer_id;

         CLOSE employee_id_cur;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            --This is a required field however PO will handle the error if these Fields are null
            l_preparer_id := NULL;
         WHEN OTHERS
         THEN
            x_return_status := fnd_api.g_ret_sts_unexp_error;
            RAISE fnd_api.g_exc_unexpected_error;
      END;

--Pass the Internal Sales Order Header values to the internal req header record
      l_req_header_rec.preparer_id := l_preparer_id;
      l_req_header_rec.summary_flag := 'N';
      l_req_header_rec.enabled_flag := 'Y';
      l_req_header_rec.authorization_status := 'APPROVED';
      l_req_header_rec.type_lookup_code := 'INTERNAL';
      l_req_header_rec.transferred_to_oe_flag := 'Y';
      l_req_header_rec.org_id := l_org_id;

--Pass the Internal Sales Order Line values to the internal req Line table
       --Here Loop for each Order Line
      FOR cur_ord_line IN ord_line_cur (p_ord_header_id)
      LOOP
         j := j + 1;

         IF cur_ord_line.item_type_code <> oe_globals.g_item_standard
         THEN
            fnd_message.set_name ('ONT', 'ONT_ISO_ITEM_TYPE_NOT_STD');
            oe_msg_pub.ADD;
            x_return_status := fnd_api.g_ret_sts_error;
            RAISE fnd_api.g_exc_error;
         END IF;

         --get the destination organization id and deliver to location id for this order line
         BEGIN
            OPEN dest_org_locn_cur (cur_ord_line.ship_to_org_id);

            FETCH dest_org_locn_cur
             INTO l_deliver_to_locn_id, l_destination_org_id;

            CLOSE dest_org_locn_cur;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               --This is a required field however PO will handle the error if these Fields are null
               l_destination_org_id := NULL;
               l_deliver_to_locn_id := NULL;
         END;

         l_req_line_tbl (j).line_num := j;
         l_req_line_tbl (j).line_type_id := 1;
         l_req_line_tbl (j).source_doc_line_reference := cur_ord_line.line_id;
         l_req_line_tbl (j).uom_code := cur_ord_line.order_quantity_uom;
         l_req_line_tbl (j).quantity := cur_ord_line.ordered_quantity;
         l_req_line_tbl (j).deliver_to_location_id := l_deliver_to_locn_id;
         l_req_line_tbl (j).destination_type_code := 'INVENTORY';
         l_req_line_tbl (j).destination_organization_id := cur_ord_line.ship_from_org_id;
         l_req_line_tbl (j).destination_subinventory := TO_CHAR (cur_ord_line.ship_to_org_id);
         l_req_line_tbl (j).to_person_id := l_preparer_id;
         l_req_line_tbl (j).source_type_code := 'INVENTORY';
         l_req_line_tbl (j).item_id := cur_ord_line.inventory_item_id;
         l_req_line_tbl (j).need_by_date := NVL (cur_ord_line.schedule_ship_date, SYSDATE);
         l_req_line_tbl (j).source_organization_id := cur_ord_line.ship_from_org_id;
         --l_req_line_tbl (j).source_subinventory := cur_ord_line.subinventory;
         l_req_line_tbl (j).org_id := cur_ord_line.org_id;
      END LOOP;

      oe_debug_pub.ADD (' auto_create_internal_req before PO API call ', 2);

--Call the PO API and pass the internal req header record and line tables to Create the Internal Req
      BEGIN                                                                                        /* Call to the Purchasing API*/
         po_create_requisition_sv.process_requisition (px_header_rec        => l_req_header_rec
                                                     , px_line_table        => l_req_line_tbl
                                                     , x_return_status      => l_int_req_ret_sts
                                                     , x_msg_count          => l_msg_count
                                                     , x_msg_data           => l_msg_data
                                                      );

--Check return status of the Purchasing API
         IF l_int_req_ret_sts = fnd_api.g_ret_sts_unexp_error
         THEN
            oe_debug_pub.ADD (' PO API call returned unexpected error ' || l_msg_data, 2);
            RAISE fnd_api.g_exc_unexpected_error;
         ELSIF l_int_req_ret_sts = fnd_api.g_ret_sts_error
         THEN
            oe_debug_pub.ADD (' PO API call returned error ' || l_msg_data, 2);
            RAISE fnd_api.g_exc_error;
         END IF;
      END;

      IF l_msg_count > 0
      THEN
         FOR v_index IN 1 .. l_msg_count
         LOOP
            oe_msg_pub.get (p_msg_index => v_index, p_encoded => 'F', p_data => l_msg_data, p_msg_index_out => v_msg_index_out);
            DBMS_OUTPUT.put_line (l_msg_data);
            DBMS_OUTPUT.put_line ('============================================================');
         END LOOP;
      END IF;

--if it returns success Update the Internal Sales Order with the Req header id and Req line Ids
      IF l_int_req_ret_sts = fnd_api.g_ret_sts_success
      THEN
--Update the header with the requisition header id
         UPDATE oe_order_headers
            SET source_document_id = l_req_header_rec.requisition_header_id
              , orig_sys_document_ref = l_req_header_rec.segment1
              , source_document_type_id = oe_globals.g_order_source_internal                               -- i.e 10  for internal
              , order_source_id = oe_globals.g_order_source_internal                                         --i.e 10 for internal
          WHERE header_id = p_ord_header_id;

         oe_debug_pub.ADD ('auto_create_internal_req after hdr update ', 2);

-- Update  the lines with the requisition header and requisition line ids, requisition number and line number
         FOR k IN 1 .. l_req_line_tbl.COUNT
         LOOP
            IF (l_req_line_tbl (k).requisition_line_id IS NOT NULL)
            THEN
               BEGIN
                  UPDATE oe_order_lines
                     SET source_document_id = l_req_header_rec.requisition_header_id
                       , source_document_line_id = l_req_line_tbl (k).requisition_line_id
                       , source_document_type_id = oe_globals.g_order_source_internal                      -- i.e 10  for internal
                       , orig_sys_document_ref = l_req_header_rec.segment1
                       , orig_sys_line_ref = l_req_line_tbl (k).line_num
                   WHERE oe_order_lines.line_id = l_req_line_tbl (k).source_doc_line_reference;
               END;
            END IF;
         END LOOP;

         oe_debug_pub.ADD ('auto_create_internal_req after line update ', 2);
      END IF;
--Handle Exceptions
   EXCEPTION
      WHEN fnd_api.g_exc_unexpected_error
      THEN
         x_return_status := fnd_api.g_ret_sts_unexp_error;
         oe_debug_pub.ADD ('auto_create_internal_req: In Unexpected error', 2);
      WHEN fnd_api.g_exc_error
      THEN
         x_return_status := fnd_api.g_ret_sts_error;
         oe_debug_pub.ADD ('auto_create_internal_req: In execution error', 2);
--WHEN NO_DATA_FOUND THEN
--x_return_status  := FND_API.G_RET_STS_SUCCESS;
--oe_debug_pub.add('auto_create_internal_req: In No DATA Found',2);
      WHEN OTHERS
      THEN
         oe_debug_pub.ADD ('auto_create_internal_req: In Other error', 2);

         IF oe_msg_pub.check_msg_level (oe_msg_pub.g_msg_lvl_unexp_error)
         THEN
            oe_msg_pub.add_exc_msg (g_pkg_name, 'auto_create_internal_req');
         END IF;

         x_return_status := fnd_api.g_ret_sts_unexp_error;
   END auto_create_internal_req;

   PROCEDURE get_move_order_details (
      p_move_order_number   IN              VARCHAR2
    , x_return_status       OUT NOCOPY      VARCHAR2
    , x_msg_count           OUT NOCOPY      NUMBER
    , x_msg_data            OUT NOCOPY      VARCHAR2
   )
   IS
      l_mo_hdr_rec        inv_move_order_pub.trohdr_rec_type;
      l_mo_hdr_val_rec    inv_move_order_pub.trohdr_val_rec_type;
      l_mo_line_tbl       inv_move_order_pub.trolin_tbl_type;
      l_mo_line_val_tbl   inv_move_order_pub.trolin_val_tbl_type;
      l_header_id         NUMBER;
      v_msg_index_out     NUMBER;
   BEGIN
--Move order transaction inserts a row into a custom table and raises an event
--This event will be dequeued to create a sales order
--If this event fails to create updates the custom table
--get move order details based on the transaction
--build order header table
--build order lines table
--submit order API
      SELECT header_id
        INTO l_header_id
        FROM mtl_txn_request_headers
       WHERE request_number = p_move_order_number;

      inv_move_order_pub.get_move_order (p_api_version_number      => 1.0
                                       , p_init_msg_list           => fnd_api.g_false
                                       , p_return_values           => fnd_api.g_false
                                       , x_return_status           => x_return_status
                                       , x_msg_count               => x_msg_count
                                       , x_msg_data                => x_msg_data
                                       , p_header_id               => l_header_id
                                       , p_header                  => fnd_api.g_miss_char
                                       , x_trohdr_rec              => l_mo_hdr_rec
                                       , x_trohdr_val_rec          => l_mo_hdr_val_rec
                                       , x_trolin_tbl              => l_mo_line_tbl
                                       , x_trolin_val_tbl          => l_mo_line_val_tbl
                                        );
      DBMS_OUTPUT.put_line (l_mo_line_tbl.COUNT);

      IF x_msg_count > 0
      THEN
         FOR v_index IN 1 .. x_msg_count
         LOOP
            fnd_msg_pub.get (p_msg_index => v_index, p_encoded => 'F', p_data => x_msg_data, p_msg_index_out => v_msg_index_out);
            DBMS_OUTPUT.put_line (x_msg_data);
            DBMS_OUTPUT.put_line ('============================================================');
         END LOOP;
      END IF;
   END;

   PROCEDURE create_customer_subinventory (p_site_use_id IN VARCHAR2, p_organization_id IN NUMBER)
   IS
      x_rowid                 VARCHAR2 (30);
      l_description           VARCHAR2 (100);
      l_material_account      NUMBER;
      l_material_oh_account   NUMBER;
      l_resource_account      NUMBER;
      l_oh_account            NUMBER;
      l_osp_account           NUMBER;
      l_expense_account       NUMBER;
      l_encumbrance_account   NUMBER;
      l_location_id           NUMBER;
      l_cost_group_id         NUMBER;
      l_party_site_number     VARCHAR2 (100);
      l_party_site_id         NUMBER;
   BEGIN
      SELECT party_name || '-' || account_number, c.party_site_id
        INTO l_description, l_party_site_id
        FROM hz_parties a, hz_cust_accounts b, hz_cust_acct_sites_all c, hz_cust_site_uses_all d
       WHERE d.site_use_id = p_site_use_id
         AND d.cust_acct_site_id = c.cust_acct_site_id
         AND c.cust_account_id = b.cust_account_id
         AND b.party_id = a.party_id;

      SELECT party_site_number
        INTO l_party_site_number
        FROM hz_party_sites
       WHERE party_site_id = l_party_site_id;

      SELECT material_account, material_overhead_account, resource_account, overhead_account, outside_processing_account
           , expense_account, encumbrance_account, default_cost_group_id
        INTO l_material_account, l_material_oh_account, l_resource_account, l_oh_account, l_osp_account
           , l_expense_account, l_encumbrance_account, l_cost_group_id
        FROM mtl_parameters
       WHERE organization_id = p_organization_id;

      SELECT location_id
        INTO l_location_id
        FROM hr_locations_all
       WHERE location_code =
                (SELECT account_number || '-' || l_party_site_number
                   FROM hz_cust_accounts b, hz_cust_acct_sites_all c, hz_cust_site_uses_all d
                  WHERE d.site_use_id = p_site_use_id
                    AND d.cust_acct_site_id = c.cust_acct_site_id
                    AND c.cust_account_id = b.cust_account_id);

      mtl_secondary_inventories_pkg.insert_row (x_rowid                           => x_rowid
                                              , x_secondary_inventory_name        => p_site_use_id
                                              , x_organization_id                 => p_organization_id
                                              , x_last_update_date                => SYSDATE
                                              , x_last_updated_by                 => fnd_profile.VALUE ('USER_ID')
                                              , x_creation_date                   => SYSDATE
                                              , x_created_by                      => fnd_profile.VALUE ('USER_ID')
                                              , x_last_update_login               => fnd_profile.VALUE ('USER_ID')
                                              , x_description                     => l_description
                                              , x_disable_date                    => NULL
                                              , x_inventory_atp_code              => 1
                                              , x_availability_type               => 1
                                              , x_reservable_type                 => 1
                                              , x_locator_type                    => 1
                                              , x_picking_order                   => NULL
                                              , x_dropping_order                  => NULL
                                              , x_material_account                => l_material_account
                                              , x_material_overhead_account       => l_material_oh_account
                                              , x_resource_account                => l_resource_account
                                              , x_overhead_account                => l_oh_account
                                              , x_outside_processing_account      => l_osp_account
                                              , x_quantity_tracked                => 1
                                              , x_asset_inventory                 => 1
                                              , x_source_type                     => NULL
                                              , x_source_subinventory             => NULL
                                              , x_source_organization_id          => NULL
                                              , x_requisition_approval_type       => 1
                                              , x_expense_account                 => l_expense_account
                                              , x_encumbrance_account             => l_encumbrance_account
                                              , x_attribute_category              => NULL
                                              , x_attribute1                      => NULL                               --custname
                                              , x_attribute2                      => NULL                             --custnumber
                                              , x_attribute3                      => NULL
                                              , x_attribute4                      => NULL
                                              , x_attribute5                      => NULL
                                              , x_attribute6                      => NULL
                                              , x_attribute7                      => NULL
                                              , x_attribute8                      => NULL
                                              , x_attribute9                      => NULL
                                              , x_attribute10                     => NULL
                                              , x_attribute11                     => NULL
                                              , x_attribute12                     => NULL
                                              , x_attribute13                     => NULL
                                              , x_attribute14                     => NULL
                                              , x_attribute15                     => NULL
                                              , x_preprocessing_lead_time         => NULL
                                              , x_processing_lead_time            => NULL
                                              , x_postprocessing_lead_time        => NULL
                                              , x_demand_class                    => NULL
                                              , x_project_id                      => NULL
                                              , x_task_id                         => NULL
                                              , x_subinventory_usage              => NULL
                                              , x_notify_list_id                  => NULL
                                              , x_depreciable_flag                => 2
                                              , x_location_id                     => l_location_id
                                              , x_status_id                       => 1
                                              , x_default_loc_status_id           => NULL
                                              , x_lpn_controlled_flag             => NULL
                                              , x_default_cost_group_id           => l_cost_group_id
                                              , x_pick_uom_code                   => NULL
                                              , x_cartonization_flag              => NULL
                                               );
   END;
END;
/

SHOW errors
/