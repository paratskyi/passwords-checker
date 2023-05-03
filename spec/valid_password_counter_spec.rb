RSpec.describe ValidPasswordCounter do
  subject { described_class.new(temp_file_path).perform }

  let(:temp_file) { Tempfile.new }
  let(:temp_file_path) { temp_file.path }

  let(:valid_password_line_1) { 'a 1-5: abcdj' }
  let(:valid_password_line_2) { 'b 3-6: bhhkkbbjjjb' }
  let(:invalid_password_line) { 'c 2-4: asfalseiruqwo' }

  let(:password_lines) { [] }
  let(:valid_password_lines) { [valid_password_line_1, valid_password_line_2] }

  before do
    password_lines.each do |password_line|
      temp_file.puts password_line
    end

    temp_file.flush
  end

  context 'without passwords' do
    let(:password_lines) { [] }

    it { expect(subject).to eq 0 }
  end

  context 'without valid passwords' do
    let(:password_lines) { [invalid_password_line] }

    it { expect(subject).to eq 0 }
  end

  context 'with valid and invalid passwords' do
    let(:password_lines) do
      [valid_password_line_1, invalid_password_line, valid_password_line_2]
    end

    it { expect(subject).to eq valid_password_lines.count }
  end

  context 'with invalid file_path' do
    let(:temp_file_path) { 'invalid' }

    it { expect(subject).to eq 0 }
  end
end