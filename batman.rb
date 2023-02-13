require 'bundler/setup'
Bundler.require(:default)

require 'active_support/all'
require_relative 'robin'

def access_token(encrypted_access_token)
  key = OpenSSL::PKey::RSA.new(ENV['PRIVATE_KEY'] || File.read('private_key.pem'))
  key.private_decrypt(Base64.decode64(encrypted_access_token))
end

buddies = YAML.load_file('batman.yml', symbolize_names: true)

seats_id_by_name = nil

errored = false
buddies.each do |buddy|
  puts "🕊️ Doing the lord's work for #{buddy[:email]}..."

  # Check whether we should book a desk for this buddy today
  today = Date.today.strftime('%A')
  if buddy[:days].none? { |day| today.downcase.start_with?(day.downcase) }
    puts "💤 Skipping because it's #{today}"
    next
  end

  robin = Robin.new(access_token(buddy[:encrypted_access_token]))
  seats_id_by_name ||= robin.seats(:wandsworth).fetch('data').to_h { |s| [s['name'], s['id']] }

  buddy[:desks].each do |seat|
    seat_id = seats_id_by_name.fetch(seat)
    response = robin.book_seat(seat_id, buddy[:email])

    case response['meta']['status_code']
    when 200
      puts "✅ Booked #{seat}"
      break
    when 409
      puts "🙅 #{seat} is already booked"
    else
      puts "❓ Something went wrong: #{response}"
    end
  end
rescue StandardError => e
  errored = true
  backtrace_cleaner = ActiveSupport::BacktraceCleaner.new
  puts [e, *backtrace_cleaner.clean(e.backtrace)].join("\n\t")
ensure
  puts '*' * 80
end

exit(1) if errored
