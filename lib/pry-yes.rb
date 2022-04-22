Pry::Commands.create_command "yes" do
  description 'Re-runs previous command with "Did you mean?" suggestion.'
  def options(opt)
    opt.on :d, :debug, 'Debug mode.'
  end

  def process
    ex = target.eval("defined?(_ex_) and _ex_")
    return unless ex && ex.message.include?("Did you mean?")

    matched_exception = ex.message.match(
      /undefined.*`(.*)'|uninitialized constant (.*)\n/)
    return unless matched_exception

    typo = matched_exception.captures.compact.first
    return unless typo

    typo_guess = ex.message.split('Did you mean?  ').last.split.first
    last_command = Pry.history.to_a[-2]
    guessed_command = last_command.gsub(typo, typo_guess)

    pry_instance.input = StringIO.new(guessed_command)
  rescue => e
    # Schhh
    raise e if opts.present?(:debug)
  ensure
    if opts.present?(:debug)
      puts "matched_exception: #{matched_exception}"
      puts "typo: #{typo}"
      puts "typo_guess: #{typo_guess}"
      puts "last_command: #{last_command}"
      puts "guessed_command: #{guessed_command}"
    end
  end
end

module PryYes; end
