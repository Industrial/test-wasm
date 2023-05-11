import fs from 'fs/promises'
import { DefaultRubyVM } from 'ruby-3_2-wasm-wasi/dist/node.cjs.js'

const main = async () => {
  try {
    const binary = await fs.readFile('./node_modules/ruby-3_2-wasm-wasi/dist/ruby.wasm')
    const module = await WebAssembly.compile(binary)
    const { vm } = await DefaultRubyVM(module)

    const mainFile = await fs.readFile('./src/main.rb')

    vm.eval(mainFile.toString())
  } catch (error) {
    console.error(error)
  }
}

main()