class Transfer
  attr_accessor :sender, :receiver, :status, :amount, :last_transfer
  

  def initialize(sender_obj, receiver_obj, amount)
    @sender = sender_obj
    @receiver = receiver_obj
    @status = "pending"
    @amount = amount
    @last_transfer = 0
  end

  def valid?
    (sender.valid?) && (receiver.valid?) ? true : false
  end

  def execute_transaction
    if valid? && sender.balance >= @amount
      sender.balance -= @amount
      receiver.balance += @amount
      @last_transfer = @amount
      @amount = 0
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    sender.balance += @last_transfer
    receiver.balance -= @last_transfer
    self.status = "reversed"
  end

end
