$bag_environment = node.chef_environment
bag_name = 'composer'
secret = Chef::Config[:encrypted_data_bag_secret]

def check_bag_existance(bag_name)
    search(bag_name, "id:#{$bag_environment}").any? ? true : log_error("You don't have a data-bag for environment: #{bag_name} / #{$bag_environment}")
end

def log_error(error_msg)
    Chef::Log.fatal(error_msg)
    fail error_msg
end

if check_bag_existance(bag_name)
    data_bag_item = data_bag_item(bag_name, $bag_environment, IO.read(secret))

    if node['composer']['auth']
        node['composer']['auth']['http-basic'].each do |host, hostObj|
            hostObj.each do |field, value|
                node.normal['composer']['auth']['http-basic']["#{host}"]["#{field}"] = data_bag_item['auth']['http-basic']["#{host}"]["#{field}"]
            end
        end
    end

    if node['composer']['auth']['github-oauth']
        node['composer']['auth']['github-oauth'].each do |host, auth|
            node.normal['composer']['auth']['github-oauth']["#{host}"] = data_bag_item['auth']['github-oauth']["#{host}"]['token']
        end
    end
end
