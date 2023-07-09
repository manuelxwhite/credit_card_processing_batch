# frozen_string_literal: true

task process_file: [:environment] do |_t, _args|
  file = ARGV.each { |a| task a.to_s do; end }.pop

  puts "Processing batch file: #{file}"

  if File.exist?("./batch_files/#{file}")
    batch_string = File.read("./batch_files/#{file}")
    transaction_batch = TransactionBatch.new(batch_string)
    transaction_batch.accounts_balances.each do |account|
      puts "#{account[:account_owner]}: #{account[:balance]}"
    end
  else
    puts 'File not found'
  end
end
