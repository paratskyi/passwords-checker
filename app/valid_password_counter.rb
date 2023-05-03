class ValidPasswordCounter
  def initialize(passwords_file_path)
    @passwords_file_path = passwords_file_path
  end

  def perform
    valid_passwords_count
  end

  private

  def valid_passwords_count
    return 0 unless File.file?(@passwords_file_path)

    File.foreach(@passwords_file_path).count do |line|
      char, count_range, password = split_line(line)

      !!(password.scan(char).join.match? /\A#{char}{#{count_range}}\z/)
    end
  end

  def split_line(line)
    splitted_line = line.split(' ')
    char = splitted_line.first
    count_range = splitted_line[1].sub('-', ',').delete(':')
    password = splitted_line.last

    [char, count_range, password]
  end
end
