const Crystal_Program = Object.create(null);
Crystal_Program.$truthy = v => !(v === Crystal_Program.nil || v === Crystal_Program.false);
Crystal_Program.$is_a = (obj, type) => obj instanceof type ? Crystal_Program.true : Crystal_Program.false;Crystal_Program['main'] = class {};
Object.defineProperty(Crystal_Program['main'].prototype.constructor, 'name', {value: 'main'});
Crystal_Program['Object'] = class {
  constructor() {
    this.$instance_vars = Object.create(null);
  }
};
Crystal_Program['Reference'] = class extends Crystal_Program['Object'] {};
Object.defineProperty(Crystal_Program['Reference'].prototype.constructor, 'name', {value: 'Reference'});
Crystal_Program['Value'] = class extends Crystal_Program['Object'] {};
Object.defineProperty(Crystal_Program['Value'].prototype.constructor, 'name', {value: 'Value'});
Crystal_Program['Number'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Number'].prototype.constructor, 'name', {value: 'Number'});
Crystal_Program['NoReturn'] = class {};
Object.defineProperty(Crystal_Program['NoReturn'].prototype.constructor, 'name', {value: 'NoReturn'});
Crystal_Program['Void'] = class {};
Object.defineProperty(Crystal_Program['Void'].prototype.constructor, 'name', {value: 'Void'});
Crystal_Program['Nil'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Nil'].prototype.constructor, 'name', {value: 'Nil'});
Crystal_Program['Bool'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Bool'].prototype.constructor, 'name', {value: 'Bool'});
Crystal_Program['Char'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Char'].prototype.constructor, 'name', {value: 'Char'});
Crystal_Program['Int'] = class extends Crystal_Program['Number'] {};
Object.defineProperty(Crystal_Program['Int'].prototype.constructor, 'name', {value: 'Int'});
Crystal_Program['Int8'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['Int8'].prototype.constructor, 'name', {value: 'Int8'});
Crystal_Program['UInt8'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['UInt8'].prototype.constructor, 'name', {value: 'UInt8'});
Crystal_Program['Int16'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['Int16'].prototype.constructor, 'name', {value: 'Int16'});
Crystal_Program['UInt16'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['UInt16'].prototype.constructor, 'name', {value: 'UInt16'});
Crystal_Program['Int32'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['Int32'].prototype.constructor, 'name', {value: 'Int32'});
Crystal_Program['UInt32'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['UInt32'].prototype.constructor, 'name', {value: 'UInt32'});
Crystal_Program['Int64'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['Int64'].prototype.constructor, 'name', {value: 'Int64'});
Crystal_Program['UInt64'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['UInt64'].prototype.constructor, 'name', {value: 'UInt64'});
Crystal_Program['Int128'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['Int128'].prototype.constructor, 'name', {value: 'Int128'});
Crystal_Program['UInt128'] = class extends Crystal_Program['Int'] {};
Object.defineProperty(Crystal_Program['UInt128'].prototype.constructor, 'name', {value: 'UInt128'});
Crystal_Program['Float'] = class extends Crystal_Program['Number'] {};
Object.defineProperty(Crystal_Program['Float'].prototype.constructor, 'name', {value: 'Float'});
Crystal_Program['Float32'] = class extends Crystal_Program['Float'] {};
Object.defineProperty(Crystal_Program['Float32'].prototype.constructor, 'name', {value: 'Float32'});
Crystal_Program['Float64'] = class extends Crystal_Program['Float'] {};
Object.defineProperty(Crystal_Program['Float64'].prototype.constructor, 'name', {value: 'Float64'});
Crystal_Program['Symbol'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Symbol'].prototype.constructor, 'name', {value: 'Symbol'});
Crystal_Program['Pointer'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Pointer'].prototype.constructor, 'name', {value: 'Pointer'});
Crystal_Program['Struct'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Struct'].prototype.constructor, 'name', {value: 'Struct'});
Crystal_Program['Pointer(UInt8)'] = class extends Crystal_Program['Struct'] {};
Object.defineProperty(Crystal_Program['Pointer(UInt8)'].prototype.constructor, 'name', {value: 'Pointer(UInt8)'});
Crystal_Program['Pointer(Pointer(UInt8))'] = class extends Crystal_Program['Struct'] {};
Object.defineProperty(Crystal_Program['Pointer(Pointer(UInt8))'].prototype.constructor, 'name', {value: 'Pointer(Pointer(UInt8))'});
Crystal_Program['Tuple'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Tuple'].prototype.constructor, 'name', {value: 'Tuple'});
Crystal_Program['Tuple()'] = class extends Crystal_Program['Struct'] {};
Object.defineProperty(Crystal_Program['Tuple()'].prototype.constructor, 'name', {value: 'Tuple()'});
Crystal_Program['Tuple(Int32,Int32,Int32)'] = class extends Crystal_Program['Struct'] {};
Object.defineProperty(Crystal_Program['Tuple(Int32,Int32,Int32)'].prototype.constructor, 'name', {value: 'Tuple(Int32,Int32,Int32)'});
Crystal_Program['NamedTuple'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['NamedTuple'].prototype.constructor, 'name', {value: 'NamedTuple'});
Crystal_Program['StaticArray'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['StaticArray'].prototype.constructor, 'name', {value: 'StaticArray'});
Crystal_Program['String'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['String'].prototype.constructor, 'name', {value: 'String'});
Crystal_Program['Object.class'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Object.class'].prototype.constructor, 'name', {value: 'Object.class'});
Crystal_Program['Array'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Array'].prototype.constructor, 'name', {value: 'Array'});
Crystal_Program['Hash'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Hash'].prototype.constructor, 'name', {value: 'Hash'});
Crystal_Program['Regex'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Regex'].prototype.constructor, 'name', {value: 'Regex'});
Crystal_Program['Range'] = class extends Crystal_Program['Struct'] {};
Object.defineProperty(Crystal_Program['Range'].prototype.constructor, 'name', {value: 'Range'});
Crystal_Program['Exception'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Exception'].prototype.constructor, 'name', {value: 'Exception'});
Crystal_Program['Enum'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Enum'].prototype.constructor, 'name', {value: 'Enum'});
Crystal_Program['Proc'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Proc'].prototype.constructor, 'name', {value: 'Proc'});
Crystal_Program['Union'] = class extends Crystal_Program['Value'] {};
Object.defineProperty(Crystal_Program['Union'].prototype.constructor, 'name', {value: 'Union'});
Crystal_Program['Crystal'] = class {};
Object.defineProperty(Crystal_Program['Crystal'].prototype.constructor, 'name', {value: 'Crystal'});
Crystal_Program['Crystal']['BUILD_COMMIT'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['BUILD_COMMIT'].prototype.constructor, 'name', {value: 'Crystal::BUILD_COMMIT'});
Crystal_Program['Crystal']['BUILD_DATE'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['BUILD_DATE'].prototype.constructor, 'name', {value: 'Crystal::BUILD_DATE'});
Crystal_Program['Crystal']['CACHE_DIR'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['CACHE_DIR'].prototype.constructor, 'name', {value: 'Crystal::CACHE_DIR'});
Crystal_Program['Crystal']['DEFAULT_PATH'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['DEFAULT_PATH'].prototype.constructor, 'name', {value: 'Crystal::DEFAULT_PATH'});
Crystal_Program['Crystal']['DESCRIPTION'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['DESCRIPTION'].prototype.constructor, 'name', {value: 'Crystal::DESCRIPTION'});
Crystal_Program['Crystal']['PATH'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['PATH'].prototype.constructor, 'name', {value: 'Crystal::PATH'});
Crystal_Program['Crystal']['LIBRARY_PATH'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['LIBRARY_PATH'].prototype.constructor, 'name', {value: 'Crystal::LIBRARY_PATH'});
Crystal_Program['Crystal']['VERSION'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['VERSION'].prototype.constructor, 'name', {value: 'Crystal::VERSION'});
Crystal_Program['Crystal']['LLVM_VERSION'] = class {};
Object.defineProperty(Crystal_Program['Crystal']['LLVM_VERSION'].prototype.constructor, 'name', {value: 'Crystal::LLVM_VERSION'});
Crystal_Program['ARGC_UNSAFE'] = class {};
Object.defineProperty(Crystal_Program['ARGC_UNSAFE'].prototype.constructor, 'name', {value: 'ARGC_UNSAFE'});
Crystal_Program['ARGV_UNSAFE'] = class {};
Object.defineProperty(Crystal_Program['ARGV_UNSAFE'].prototype.constructor, 'name', {value: 'ARGV_UNSAFE'});
Crystal_Program['GC'] = class {};
Object.defineProperty(Crystal_Program['GC'].prototype.constructor, 'name', {value: 'GC'});
Crystal_Program['AlwaysInline'] = class {};
Object.defineProperty(Crystal_Program['AlwaysInline'].prototype.constructor, 'name', {value: 'AlwaysInline'});
Crystal_Program['CallConvention'] = class {};
Object.defineProperty(Crystal_Program['CallConvention'].prototype.constructor, 'name', {value: 'CallConvention'});
Crystal_Program['Extern'] = class {};
Object.defineProperty(Crystal_Program['Extern'].prototype.constructor, 'name', {value: 'Extern'});
Crystal_Program['Flags'] = class {};
Object.defineProperty(Crystal_Program['Flags'].prototype.constructor, 'name', {value: 'Flags'});
Crystal_Program['Link'] = class {};
Object.defineProperty(Crystal_Program['Link'].prototype.constructor, 'name', {value: 'Link'});
Crystal_Program['Naked'] = class {};
Object.defineProperty(Crystal_Program['Naked'].prototype.constructor, 'name', {value: 'Naked'});
Crystal_Program['NoInline'] = class {};
Object.defineProperty(Crystal_Program['NoInline'].prototype.constructor, 'name', {value: 'NoInline'});
Crystal_Program['Packed'] = class {};
Object.defineProperty(Crystal_Program['Packed'].prototype.constructor, 'name', {value: 'Packed'});
Crystal_Program['Primitive'] = class {};
Object.defineProperty(Crystal_Program['Primitive'].prototype.constructor, 'name', {value: 'Primitive'});
Crystal_Program['Raises'] = class {};
Object.defineProperty(Crystal_Program['Raises'].prototype.constructor, 'name', {value: 'Raises'});
Crystal_Program['ReturnsTwice'] = class {};
Object.defineProperty(Crystal_Program['ReturnsTwice'].prototype.constructor, 'name', {value: 'ReturnsTwice'});
Crystal_Program['ThreadLocal'] = class {};
Object.defineProperty(Crystal_Program['ThreadLocal'].prototype.constructor, 'name', {value: 'ThreadLocal'});
Crystal_Program['Deprecated'] = class {};
Object.defineProperty(Crystal_Program['Deprecated'].prototype.constructor, 'name', {value: 'Deprecated'});
Crystal_Program['SimpleClass'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['SimpleClass'].prototype.constructor, 'name', {value: 'SimpleClass'});
Crystal_Program['Foo'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Foo'].prototype.constructor, 'name', {value: 'Foo'});
Crystal_Program['Foo']['SubFoo'] = class extends Crystal_Program['Foo'] {};
Object.defineProperty(Crystal_Program['Foo']['SubFoo'].prototype.constructor, 'name', {value: 'Foo::SubFoo'});
Crystal_Program['Foo(String,String)'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Foo(String,String)'].prototype.constructor, 'name', {value: 'Foo(String,String)'});
Crystal_Program['Foo']['SubFoo(String,String)'] = class extends Crystal_Program['Foo(String,String)'] {};
Object.defineProperty(Crystal_Program['Foo']['SubFoo(String,String)'].prototype.constructor, 'name', {value: 'Foo::SubFoo(String,String)'});
Crystal_Program['Foo(Int32,String)'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Foo(Int32,String)'].prototype.constructor, 'name', {value: 'Foo(Int32,String)'});
Crystal_Program['Foo']['SubFoo(Int32,String)'] = class extends Crystal_Program['Foo(Int32,String)'] {};
Object.defineProperty(Crystal_Program['Foo']['SubFoo(Int32,String)'].prototype.constructor, 'name', {value: 'Foo::SubFoo(Int32,String)'});
Crystal_Program['Foo((Int32|String),String)'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Foo((Int32|String),String)'].prototype.constructor, 'name', {value: 'Foo((Int32|String),String)'});
Crystal_Program['Foo']['SubFoo((Int32|String),String)'] = class extends Crystal_Program['Foo((Int32|String),String)'] {};
Object.defineProperty(Crystal_Program['Foo']['SubFoo((Int32|String),String)'].prototype.constructor, 'name', {value: 'Foo::SubFoo((Int32|String),String)'});
Crystal_Program['Foo((Nil|Foo::SubFoo(String,String)),Int32)'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Foo((Nil|Foo::SubFoo(String,String)),Int32)'].prototype.constructor, 'name', {value: 'Foo((Nil|Foo::SubFoo(String,String)),Int32)'});
Crystal_Program['Foo((Nil|Foo::SubFoo(Int32,String)),Int32)'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Foo((Nil|Foo::SubFoo(Int32,String)),Int32)'].prototype.constructor, 'name', {value: 'Foo((Nil|Foo::SubFoo(Int32,String)),Int32)'});
Crystal_Program['Foo((Nil|Foo::SubFoo((Int32|String),String)),Int32)'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['Foo((Nil|Foo::SubFoo((Int32|String),String)),Int32)'].prototype.constructor, 'name', {value: 'Foo((Nil|Foo::SubFoo((Int32|String),String)),Int32)'});
Crystal_Program['Bar'] = class extends Crystal_Program['Foo'] {};
Object.defineProperty(Crystal_Program['Bar'].prototype.constructor, 'name', {value: 'Bar'});
Crystal_Program['Bar(String)'] = class extends Crystal_Program['Foo((Nil|Foo::SubFoo(String,String)),Int32)'] {};
Object.defineProperty(Crystal_Program['Bar(String)'].prototype.constructor, 'name', {value: 'Bar(String)'});
Crystal_Program['Bar(Int32)'] = class extends Crystal_Program['Foo((Nil|Foo::SubFoo(Int32,String)),Int32)'] {};
Object.defineProperty(Crystal_Program['Bar(Int32)'].prototype.constructor, 'name', {value: 'Bar(Int32)'});
Crystal_Program['Bar((Int32|String))'] = class extends Crystal_Program['Foo((Nil|Foo::SubFoo((Int32|String),String)),Int32)'] {};
Object.defineProperty(Crystal_Program['Bar((Int32|String))'].prototype.constructor, 'name', {value: 'Bar((Int32|String))'});
Crystal_Program['M11'] = class {};
Object.defineProperty(Crystal_Program['M11'].prototype.constructor, 'name', {value: 'M11'});
Crystal_Program['M12'] = class {};
Object.defineProperty(Crystal_Program['M12'].prototype.constructor, 'name', {value: 'M12'});
Crystal_Program['M2'] = class {};
Object.defineProperty(Crystal_Program['M2'].prototype.constructor, 'name', {value: 'M2'});
Crystal_Program['C'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['C'].prototype.constructor, 'name', {value: 'C'});
Crystal_Program['GenericModule'] = class {};
Object.defineProperty(Crystal_Program['GenericModule'].prototype.constructor, 'name', {value: 'GenericModule'});
Crystal_Program['GenericModule(Int32)'] = class {};
Object.defineProperty(Crystal_Program['GenericModule(Int32)'].prototype.constructor, 'name', {value: 'GenericModule(Int32)'});
Crystal_Program['GenericClass'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['GenericClass'].prototype.constructor, 'name', {value: 'GenericClass'});
Crystal_Program['GenericClass(Int32)'] = class extends Crystal_Program['Reference'] {};
Object.defineProperty(Crystal_Program['GenericClass(Int32)'].prototype.constructor, 'name', {value: 'GenericClass(Int32)'});
((typeTag) => {
  Object.defineProperty(Crystal_Program['main'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['main'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Object'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Object'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Reference'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Reference'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Value'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Value'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Number'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Number'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['NoReturn'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['NoReturn'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Void'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Void'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Nil'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Nil'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Bool'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Bool'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Char'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Char'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Int'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Int'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Int8'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Int8'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['UInt8'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['UInt8'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Int16'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Int16'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['UInt16'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['UInt16'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Int32'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Int32'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['UInt32'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['UInt32'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Int64'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Int64'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['UInt64'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['UInt64'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Int128'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Int128'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['UInt128'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['UInt128'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Float'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Float'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Float32'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Float32'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Float64'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Float64'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Symbol'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Symbol'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Pointer'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Pointer'].prototype[typeTag] = true;
  Crystal_Program['Pointer(UInt8)'].prototype[typeTag] = true;
  Crystal_Program['Pointer(Pointer(UInt8))'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Pointer(UInt8)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Pointer(UInt8)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Pointer(Pointer(UInt8))'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Pointer(Pointer(UInt8))'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Tuple'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Tuple'].prototype[typeTag] = true;
  Crystal_Program['Tuple()'].prototype[typeTag] = true;
  Crystal_Program['Tuple(Int32,Int32,Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Tuple()'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Tuple()'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Tuple(Int32,Int32,Int32)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Tuple(Int32,Int32,Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['NamedTuple'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['NamedTuple'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['StaticArray'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['StaticArray'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['String'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['String'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Object.class'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Object.class'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Struct'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Struct'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Array'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Array'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Hash'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Hash'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Regex'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Regex'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Range'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Range'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Exception'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Exception'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Enum'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Enum'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Proc'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Proc'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Union'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Union'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['BUILD_COMMIT'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['BUILD_COMMIT'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['BUILD_DATE'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['BUILD_DATE'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['CACHE_DIR'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['CACHE_DIR'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['DEFAULT_PATH'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['DEFAULT_PATH'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['DESCRIPTION'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['DESCRIPTION'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['PATH'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['PATH'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['LIBRARY_PATH'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['LIBRARY_PATH'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['VERSION'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['VERSION'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Crystal']['LLVM_VERSION'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Crystal']['LLVM_VERSION'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['ARGC_UNSAFE'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['ARGC_UNSAFE'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['ARGV_UNSAFE'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['ARGV_UNSAFE'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['GC'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['GC'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['AlwaysInline'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['AlwaysInline'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['CallConvention'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['CallConvention'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Extern'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Extern'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Flags'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Flags'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Link'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Link'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Naked'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Naked'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['NoInline'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['NoInline'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Packed'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Packed'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Primitive'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Primitive'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Raises'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Raises'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['ReturnsTwice'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['ReturnsTwice'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['ThreadLocal'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['ThreadLocal'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Deprecated'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Deprecated'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['SimpleClass'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['SimpleClass'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo'].prototype[typeTag] = true;
  Crystal_Program['Foo(String,String)'].prototype[typeTag] = true;
  Crystal_Program['Foo(Int32,String)'].prototype[typeTag] = true;
  Crystal_Program['Foo((Int32|String),String)'].prototype[typeTag] = true;
  Crystal_Program['Foo((Nil|Foo::SubFoo(String,String)),Int32)'].prototype[typeTag] = true;
  Crystal_Program['Foo((Nil|Foo::SubFoo(Int32,String)),Int32)'].prototype[typeTag] = true;
  Crystal_Program['Foo((Nil|Foo::SubFoo((Int32|String),String)),Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo']['SubFoo'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo']['SubFoo'].prototype[typeTag] = true;
  Crystal_Program['Foo']['SubFoo(String,String)'].prototype[typeTag] = true;
  Crystal_Program['Foo']['SubFoo(Int32,String)'].prototype[typeTag] = true;
  Crystal_Program['Foo']['SubFoo((Int32|String),String)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo']['SubFoo(String,String)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo']['SubFoo(String,String)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo(String,String)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo(String,String)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo']['SubFoo(Int32,String)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo']['SubFoo(Int32,String)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo(Int32,String)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo(Int32,String)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo']['SubFoo((Int32|String),String)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo']['SubFoo((Int32|String),String)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo((Int32|String),String)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo((Int32|String),String)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo((Nil|Foo::SubFoo(String,String)),Int32)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo((Nil|Foo::SubFoo(String,String)),Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo((Nil|Foo::SubFoo(Int32,String)),Int32)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo((Nil|Foo::SubFoo(Int32,String)),Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Foo((Nil|Foo::SubFoo((Int32|String),String)),Int32)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Foo((Nil|Foo::SubFoo((Int32|String),String)),Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Bar'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Bar'].prototype[typeTag] = true;
  Crystal_Program['Bar(String)'].prototype[typeTag] = true;
  Crystal_Program['Bar(Int32)'].prototype[typeTag] = true;
  Crystal_Program['Bar((Int32|String))'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Bar(String)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Bar(String)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Bar(Int32)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Bar(Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['Bar((Int32|String))'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['Bar((Int32|String))'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['M11'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['M11'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['M12'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['M12'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['M2'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['M2'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['C'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['C'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['GenericModule'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['GenericModule'].prototype[typeTag] = true;
  Crystal_Program['GenericModule(Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['GenericModule(Int32)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['GenericModule(Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['GenericClass'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['GenericClass'].prototype[typeTag] = true;
  Crystal_Program['GenericClass(Int32)'].prototype[typeTag] = true;
})(Symbol());
((typeTag) => {
  Object.defineProperty(Crystal_Program['GenericClass(Int32)'], Symbol.hasInstance, {value: instance => instance[typeTag]});
  Crystal_Program['GenericClass(Int32)'].prototype[typeTag] = true;
})(Symbol());
Object.assign(Crystal_Program['C'].prototype, Crystal_Program['M12'].prototype, Crystal_Program['M11'].prototype);
Object.assign(Crystal_Program['GenericClass'].prototype, Crystal_Program['GenericModule'].prototype);
Object.assign(Crystal_Program['GenericClass(Int32)'].prototype, Crystal_Program['GenericModule(Int32)'].prototype);
Crystal_Program['main'].prototype['puts'] = Object.create(null);
Crystal_Program['main'].prototype['puts']['Int32,'] = function(__temp_1,) {
undefined /* Crystal::Primitive # primitive: io */
};
Crystal_Program['main'].prototype['test'] = Object.create(null);
Crystal_Program['main'].prototype['test'][''] = function() {
let sc = Crystal_Program['SimpleClass']['new']['']();
let a = Crystal_Program['Bar(String)']['new']['']();
a['method']['String,'](((() => {
  let _ = new Crystal_Program['String'];
  _.$value = "Hello";
  return _;
})()),);
a['method']['Nil,']((Crystal_Program.nil),);
a['method:x']['Int32,'](((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 11;
  return _;
})()),);
a['method:x']['String,'](((() => {
  let _ = new Crystal_Program['String'];
  _.$value = "World";
  return _;
})()),);
a['method:x:y']['Int32,Int32,'](((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 1;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 3;
  return _;
})()),);
a['method:y:x']['Int32,Int32,'](((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 3;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 1;
  return _;
})()),);
a['method']['Int32,Int32,Int32,Int32,Int32,'](((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 1;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 2;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 3;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 4;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 5;
  return _;
})()),);
a['method']['Bar(Int32),']((Crystal_Program['Bar(Int32)']['new']['']()),);
a['method']['Bar(String),']((Crystal_Program['Bar(String)']['new']['']()),);
a['method']['Bar((Int32|String)),']((Crystal_Program['Bar((Int32|String))']['new']['']()),)

};
Crystal_Program['main'].prototype['call'] = Object.create(null);
Crystal_Program['main'].prototype['call'][''] = function() {
let gc = Crystal_Program['GenericClass(Int32)']['new']['']();
undefined /* TODO: obj-less call puts(gc.id_t(4)) */;
undefined /* TODO: obj-less call puts(gc.id(11)) */;
undefined /* TODO: obj-less call puts(gc.id("world")) */

};
Crystal_Program['main'].prototype['puts']['String,'] = function(__temp_11,) {
undefined /* Crystal::Primitive # primitive: io */
};
Crystal_Program['Int32'].prototype['+'] = Object.create(null);
Crystal_Program['Int32'].prototype['+']['Int32,'] = function(other,) {
undefined /* Crystal::Primitive # primitive: binary */
};
Crystal_Program['Bar(String)'].prototype['initialize'] = Object.create(null);
Crystal_Program['Bar(String)'].prototype['initialize'][''] = function() {

};
Crystal_Program['Bar(String)'].prototype['method'] = Object.create(null);
Crystal_Program['Bar(String)'].prototype['method']['String,'] = function(arg,) {

};
Crystal_Program['Bar(String)'].prototype['method']['Nil,'] = function(arg,) {

};
Crystal_Program['Bar(String)'].prototype['method:x'] = Object.create(null);
Crystal_Program['Bar(String)'].prototype['method:x']['Int32,'] = function(x,) {
let y = (() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 7;
  return _;
})();
let args = (() => {
  let _ = new Crystal_Program['Tuple()'];
  _.$value = [];
  return _;
})();


};
Crystal_Program['Bar(String)'].prototype['method:x']['String,'] = function(x,) {
let y = (() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 7;
  return _;
})();
let args = (() => {
  let _ = new Crystal_Program['Tuple()'];
  _.$value = [];
  return _;
})();


};
Crystal_Program['Bar(String)'].prototype['method:x:y'] = Object.create(null);
Crystal_Program['Bar(String)'].prototype['method:x:y']['Int32,Int32,'] = function(x,y,) {
let args = (() => {
  let _ = new Crystal_Program['Tuple()'];
  _.$value = [];
  return _;
})();


};
Crystal_Program['Bar(String)'].prototype['method:y:x'] = Object.create(null);
Crystal_Program['Bar(String)'].prototype['method:y:x']['Int32,Int32,'] = function(y,x,) {
let args = (() => {
  let _ = new Crystal_Program['Tuple()'];
  _.$value = [];
  return _;
})();


};
Crystal_Program['Bar(String)'].prototype['method']['Int32,Int32,Int32,Int32,Int32,'] = function(x,y,__temp_8,__temp_9,__temp_10,) {
let args = (() => {
  let _ = new Crystal_Program['Tuple(Int32,Int32,Int32)'];
  _.$value = [__temp_8,__temp_9,__temp_10,];
  return _;
})();


};
Crystal_Program['Bar(String)'].prototype['method']['Bar(Int32),'] = function(arr,) {

};
Crystal_Program['Bar(String)'].prototype['method']['Bar(String),'] = function(arr,) {

};
Crystal_Program['Bar(String)'].prototype['method']['Bar((Int32|String)),'] = function(arr,) {

};
Crystal_Program['Bar(Int32)'].prototype['initialize'] = Object.create(null);
Crystal_Program['Bar(Int32)'].prototype['initialize'][''] = function() {

};
Crystal_Program['Bar((Int32|String))'].prototype['initialize'] = Object.create(null);
Crystal_Program['Bar((Int32|String))'].prototype['initialize'][''] = function() {

};
Crystal_Program['C'].prototype['method1'] = Object.create(null);
Crystal_Program['C'].prototype['method1'][''] = function() {

};
Crystal_Program['C'].prototype['method2'] = Object.create(null);
Crystal_Program['C'].prototype['method2'][''] = function() {

};
Crystal_Program['GenericClass(Int32)'].prototype['initialize'] = Object.create(null);
Crystal_Program['GenericClass(Int32)'].prototype['initialize'][''] = function() {

};
Crystal_Program['GenericClass(Int32)'].prototype['id_t'] = Object.create(null);
Crystal_Program['GenericClass(Int32)'].prototype['id_t']['Int32,'] = function(t,) {
t
};
Crystal_Program['GenericClass(Int32)'].prototype['id'] = Object.create(null);
Crystal_Program['GenericClass(Int32)'].prototype['id']['Int32,'] = function(u,) {
u
};
Crystal_Program['GenericClass(Int32)'].prototype['id']['String,'] = function(u,) {
u
};
Object.assign(Crystal_Program['M2'], Crystal_Program['M12'].prototype, Crystal_Program['M11'].prototype)
Crystal_Program['main']['puts'] = Object.create(null);
Crystal_Program['main']['puts']['Int32,'] = function(__temp_1,) {
undefined /* Crystal::Primitive # primitive: io */
};
Crystal_Program['main']['test'] = Object.create(null);
Crystal_Program['main']['test'][''] = function() {
let sc = Crystal_Program['SimpleClass']['new']['']();
let a = Crystal_Program['Bar(String)']['new']['']();
a['method']['String,'](((() => {
  let _ = new Crystal_Program['String'];
  _.$value = "Hello";
  return _;
})()),);
a['method']['Nil,']((Crystal_Program.nil),);
a['method:x']['Int32,'](((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 11;
  return _;
})()),);
a['method:x']['String,'](((() => {
  let _ = new Crystal_Program['String'];
  _.$value = "World";
  return _;
})()),);
a['method:x:y']['Int32,Int32,'](((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 1;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 3;
  return _;
})()),);
a['method:y:x']['Int32,Int32,'](((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 3;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 1;
  return _;
})()),);
a['method']['Int32,Int32,Int32,Int32,Int32,'](((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 1;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 2;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 3;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 4;
  return _;
})()),((() => {
  let _ = new Crystal_Program['Int32'];
  _.$value = 5;
  return _;
})()),);
a['method']['Bar(Int32),']((Crystal_Program['Bar(Int32)']['new']['']()),);
a['method']['Bar(String),']((Crystal_Program['Bar(String)']['new']['']()),);
a['method']['Bar((Int32|String)),']((Crystal_Program['Bar((Int32|String))']['new']['']()),)

};
Crystal_Program['main']['call'] = Object.create(null);
Crystal_Program['main']['call'][''] = function() {
let gc = Crystal_Program['GenericClass(Int32)']['new']['']();
undefined /* TODO: obj-less call puts(gc.id_t(4)) */;
undefined /* TODO: obj-less call puts(gc.id(11)) */;
undefined /* TODO: obj-less call puts(gc.id("world")) */

};
Crystal_Program['main']['puts']['String,'] = function(__temp_11,) {
undefined /* Crystal::Primitive # primitive: io */
};
Crystal_Program['SimpleClass']['new'] = Object.create(null);
Crystal_Program['SimpleClass']['new'][''] = function() {
let x = undefined /* TODO: obj-less call allocate */;
if (Crystal_Program.false) {

} else {

};
x

};
Crystal_Program['SimpleClass']['allocate'] = Object.create(null);
Crystal_Program['SimpleClass']['allocate'][''] = function() {
  return new Crystal_Program['SimpleClass']();
};
Crystal_Program['Bar(String)']['new'] = Object.create(null);
Crystal_Program['Bar(String)']['new'][''] = function() {
let _ = Crystal_Program['Bar(String)']['allocate']['']();
_['initialize']['']();
if (Crystal_Program.false) {

} else {

};
return _;

};
Crystal_Program['Bar(String)']['allocate'] = Object.create(null);
Crystal_Program['Bar(String)']['allocate'][''] = function() {
  return new Crystal_Program['Bar(String)']();
};
Crystal_Program['Bar(Int32)']['new'] = Object.create(null);
Crystal_Program['Bar(Int32)']['new'][''] = function() {
let _ = Crystal_Program['Bar(Int32)']['allocate']['']();
_['initialize']['']();
if (Crystal_Program.false) {

} else {

};
_

};
Crystal_Program['Bar(Int32)']['allocate'] = Object.create(null);
Crystal_Program['Bar(Int32)']['allocate'][''] = function() {
  return new Crystal_Program['Bar(Int32)']();
};
Crystal_Program['Bar((Int32|String))']['new'] = Object.create(null);
Crystal_Program['Bar((Int32|String))']['new'][''] = function() {
let _ = Crystal_Program['Bar((Int32|String))']['allocate']['']();
_['initialize']['']();
if (Crystal_Program.false) {

} else {

};
_

};
Crystal_Program['Bar((Int32|String))']['allocate'] = Object.create(null);
Crystal_Program['Bar((Int32|String))']['allocate'][''] = function() {
  return new Crystal_Program['Bar((Int32|String))']();
};
Crystal_Program['C']['new'] = Object.create(null);
Crystal_Program['C']['new'][''] = function() {
let x = undefined /* TODO: obj-less call allocate */;
if (Crystal_Program.false) {

} else {

};
x

};
Crystal_Program['C']['allocate'] = Object.create(null);
Crystal_Program['C']['allocate'][''] = function() {
  return new Crystal_Program['C']();
};
Crystal_Program['GenericClass(Int32)']['new'] = Object.create(null);
Crystal_Program['GenericClass(Int32)']['new'][''] = function() {
let _ = Crystal_Program['GenericClass(Int32)']['allocate']['']();
_['initialize']['']();
if (Crystal_Program.false) {

} else {

};
_

};
Crystal_Program['GenericClass(Int32)']['allocate'] = Object.create(null);
Crystal_Program['GenericClass(Int32)']['allocate'][''] = function() {
  return new Crystal_Program['GenericClass(Int32)']();
};
Crystal_Program.nil = new Crystal_Program.Nil();
Crystal_Program.true = new Crystal_Program.Bool();
Crystal_Program.false = new Crystal_Program.Bool();

Crystal_Program['main']['test']['']();