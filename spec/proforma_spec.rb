# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe ::Proforma do
  let(:snapshot_dir) { File.join('spec', 'fixtures', 'snapshots', '*.yml') }

  let(:snapshot_filenames) { Dir[snapshot_dir] }

  it 'should process each snapshot successfully' do
    snapshot_filenames.each do |file|
      contents = yaml_read(file)

      expected_documents = Proforma::Document.array(contents['documents'])

      actual_documents = described_class.render(
        contents['data'],
        contents['template'],
        evaluator: contents['evaluator'] || Proforma::HashEvaluator.new,
        renderer: contents['renderer'] || Proforma::PlainTextRenderer.new
      )

      expect(actual_documents).to eq(expected_documents)
    end
  end

  describe 'README examples' do
    specify 'Getting Started: Rendering a List' do
      data = [
        { id: 1, first: 'Matt', last: 'Smith' },
        { id: 2, first: 'Katie', last: 'Rizzo' },
        { id: 3, first: 'Nathan', last: 'Nathanson' }
      ]

      template = {
        title: 'User List',
        children: [
          {
            type: 'DataTable',
            columns: [
              { header: 'ID Number', body: '$id' },
              { header: 'First Name', body: '$first' },
              { header: 'Last Name', body: '$last' }
            ]
          }
        ]
      }

      actual_documents = described_class.render(data, template)

      expected_documents = [
        Proforma::Document.new(
          contents: "ID Number, First Name, Last Name\n1, Matt, Smith"\
                    "\n2, Katie, Rizzo\n3, Nathan, Nathanson\n",
          extension: '.txt',
          title: 'User List'
        )
      ]

      expect(actual_documents).to eq(expected_documents)
    end

    specify 'Rendering Records' do
      data = [
        { id: 1, first: 'Matt', last: 'Smith' },
        { id: 2, first: 'Katie', last: 'Rizzo' },
        { id: 3, first: 'Nathan', last: 'Nathanson' }
      ]

      template = {
        title: 'User Details',
        split: true, # notice the split directive here.
        children: [
          {
            type: 'Pane',
            columns: [
              {
                lines: [
                  { label: 'ID Number', value: '$id' },
                  { label: 'First Name', value: '$first' }
                ]
              },
              {
                lines: [
                  { label: 'Last Name', value: '$last' }
                ]
              }
            ]
          }
        ]
      }

      actual_documents = Proforma.render(data, template)

      expected_documents = [
        Proforma::Document.new(
          contents: "ID Number: 1\nFirst Name: Matt\nLast Name: Smith\n",
          extension: '.txt',
          title: 'User Details'
        ),
        Proforma::Document.new(
          contents: "ID Number: 2\nFirst Name: Katie\nLast Name: Rizzo\n",
          extension: '.txt',
          title: 'User Details'
        ),
        Proforma::Document.new(
          contents: "ID Number: 3\nFirst Name: Nathan\nLast Name: Nathanson\n",
          extension: '.txt',
          title: 'User Details'
        )
      ]

      expect(actual_documents).to eq(expected_documents)
    end

    specify 'Bringing It All Together' do
      data = [
        {
          id: 1,
          first: 'Matt',
          last: 'Smith',
          phone_numbers: [
            { type: 'Mobile', number: '444-333-2222' },
            { type: 'Home', number: '444-333-2222' }
          ]
        },
        {
          id: 2,
          first: 'Katie',
          last: 'Rizzo',
          phone_numbers: [
            { type: 'Fax', number: '888-777-6666' }
          ]
        },
        {
          id: 3,
          first: 'Nathan',
          last: 'Nathanson',
          phone_numbers: []
        }
      ]

      template = {
        title: 'User Report',
        children: [
          {
            type: 'Banner',
            title: 'System A',
            details: "555 N. Michigan Ave.\nChicago, IL 55555\n555-555-5555 ext. 5132"
          },
          { type: 'Header', value: 'User List' },
          { type: 'Separator' },
          { type: 'Spacer' },
          {
            type: 'DataTable',
            columns: [
              { header: 'ID Number', body: '$id' },
              { header: 'First Name', body: '$first' },
              { header: 'Last Name', body: '$last' }
            ]
          },
          { type: 'Spacer' },
          {
            type: 'Grouping',
            children: [
              { type: 'Header', value: 'User Details' },
              { type: 'Separator' },
              { type: 'Spacer' },
              {
                type: 'Pane',
                columns: [
                  {
                    lines: [
                      { label: 'ID Number', value: '$id' },
                      { label: 'First Name', value: '$first' }
                    ]
                  },
                  {
                    lines: [
                      { label: 'Last Name', value: '$last' }
                    ]
                  }
                ]
              },
              {
                type: 'DataTable',
                property: 'phone_numbers',
                columns: [
                  { header: 'Type', body: '$type' },
                  { header: 'Number', body: '$number' }
                ]
              },
              { type: 'Spacer' }
            ]
          }
        ]
      }

      actual_documents = Proforma.render(data, template)

      expected_documents = [
        Proforma::Document.new(
          contents: fixture('bringing_it_all_together.txt'),
          extension: '.txt',
          title: 'User Report'
        )
      ]

      expect(actual_documents).to eq(expected_documents)
    end
  end
end
