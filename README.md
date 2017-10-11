# Jsonar

Jsonar is a command-line tool for searching into JSON files.

For example, given the below JSON file:

```
[
    { "name": "apple",
      "color": "red"
    },
    { "name": "grape",
      "color": "green"
    },
    { "name": "strawberry",
      "color": "red"
    }
]
```

a search for `red` would return:

```
[
    { "name": "apple",
      "color": "red"
    },
    { "name": "strawberry",
      "color": "red"
    }
]
```

## Installation

Jsonar is available on rubygems.org and can be easily installed with

    $ gem install jsonar

## Usage

    $ jsonar path-to-json-file

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shioju/jsonar.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
