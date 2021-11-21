using FactoryBot::Refinements::RSpec

describe FactoryBot::Refinements::RSpec do
  describe 'basic usage' do
    create :user,                 name: 'john'
    create :user.as(:ursm),       name: 'ursm'
    build  :user.as(:tricknotes), name: 'tricknotes'

    example do
      expect(user).to have_attributes(
        name:       'john',
        persisted?: true,
      )

      expect(ursm).to have_attributes(
        name:       'ursm',
        persisted?: true,
      )

      expect(tricknotes).to have_attributes(
        name:       'tricknotes',
        persisted?: false,
      )
    end
  end

  describe 'immediate and lazy' do
    create(:user.as(:alice))      { @alice = true }
    build(:user.as(:bob))         { @bob   = true }
    create_lazy(:user.as(:carol)) { @carol = true }
    build_lazy(:user.as(:dan))    { @dan   = true }

    def evaluated?(name)
      self.class.instance_variable_get(:"@#{name}") == true
    end

    example do
      expect(self).to be_evaluated(:alice)
      expect(self).to be_evaluated(:bob)

      expect { carol }.to change { evaluated?(:carol) }.from(false).to(true)
      expect { dan   }.to change { evaluated?(:dan)   }.from(false).to(true)
    end
  end
end
