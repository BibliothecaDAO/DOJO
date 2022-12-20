// we use the ID here as cairo doesn't like importing const from files with constructors
const ID = 'example.component.Location';

// we use generic name at the component level, so we can reuse functions at the system level
// Position
struct ComponentStruct {
    x: felt,
    y: felt,
}
