Deface::Override.new(virtual_path:  "spree/admin/shared/_product_tabs",
                     name:          "commission_agent_link",
                     insert_bottom: "[data-hook='admin_product_tabs']",
                     text: %(
                      <%= content_tag :li do %>
                        <%= link_to_with_icon 'icon-edit', 'Commission Agents', spree.admin_product_commission_agents_path(@product) %>
                      <% end %>
                     ),
                     disabled: false)