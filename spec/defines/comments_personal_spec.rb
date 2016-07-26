require 'spec_helper'

require 'pry'

describe 'comments::personal' do
  let(:title) { "greg" }
  let(:params) { {  'path'     => '/tmp/comments',
                    'filename' => 'comments.txt',
                    'comment'  => 'Rocking the test!'} }

  describe 'expected defaults' do
    it { is_expected.to contain_comments__personal('greg').with({ 'name' => 'greg',
                                                        'path'     => '/tmp/comments',
                                                        'filename' => 'comments.txt',
                                                        'comment'  => 'Rocking the test!' })}
  end
end
