Deface::Override.new(virtual_path:  "spree/admin/shared/_product_tabs",
                     name:          "commission_agent_link",
                     insert_bottom: "[data-hook='admin_product_tabs']",
                     text: %(
                      <%= content_tag :li do %>
                        <%= link_to_with_icon 'icon-edit', 'Commission Agents', spree.admin_product_commission_agents_path(@product) %>
                      <% end %>
                     ),
                     disabled: false)

Deface::Override.new(virtual_path:  "spree/admin/users/_sidebar",
                     name:          "commission_agent_payment_link",
                     insert_bottom: "[data-hook='admin_user_tab_options']",
                     text: %(
                      <li<%== ' class="active"' if current == :commission_payments %>>
                        <%= link_to_with_icon 'edit', Spree.t(:"admin.user.commission_payments"), spree.admin_user_commission_payments_path(@user) %>
                      </li>
                     ),
                     disabled: false)

Deface::Override.new(virtual_path:  "spree/admin/users/_sidebar",
                     name:          "commission_agent_stats",
                     insert_after: "[data-hook='admin_user_lifetime_stats']",
                     partial: 'spree/admin/commission_payments/sidebar_commission_payments',
                     disabled: false)