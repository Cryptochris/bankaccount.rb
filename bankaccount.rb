# bankaccount.rb
class BankAccount
  attr_reader :name

  def initialize(name, opening_balance = 0)
    @name = name
    @transactions = []
    add_transaction('Beginning Balance', opening_balance)
  end

  def credit(description, amount)
    add_transaction(description, amount)
  end

  def debit(description, amount)
    add_transaction(description, -amount)
  end

  def add_transaction(description, amount)
    @transactions.push(description: description, amount: amount)
  end

  def balance
    @transactions.reduce(0) do |memo, transaction|
      memo + transaction[:amount]
    end
  end

  def to_s
    my_string = 'Name: %s, Balance: %0.2f'
    format(my_string, name, balance)
  end

  def print_register
    # rubocop:disable Style/SpaceInsideStringInterpolation
    puts(<<~EOS

    #{name}'s Bank Account
    #{border = '-' * 40}

    #{'Description'.ljust(30) + 'Amount'.rjust(10)}
    #{
    @transactions.map do |transaction|
      transaction[:description].ljust(30) + format('%0.2f', transaction[:amount]).rjust(10)
    end.join("\n")
    }

    #{border}
    #{'Balance:'.ljust(30) + format('%0.2f', balance).rjust(10)}
    #{border}
    EOS
        )
  end
end

if __FILE__ == $PROGRAM_NAME
  bank_account = BankAccount.new('Jason', 250.00)
  bank_account.credit('Paycheck', 100)
  bank_account.debit('Groceries', 40)
  bank_account.debit('Gas', 10.51)
  puts bank_account
  puts 'Register:'
  bank_account.print_register
end
