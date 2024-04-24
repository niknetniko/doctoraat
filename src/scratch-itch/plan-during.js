function duringExecution(e) {
  const runtime = e.vm.runtime;
  // Save the original sizes of the sprites.
  const oldSize = {
    "Giga": runtime.getSpriteTargetByName("Giga").size,
    "Pico": runtime.getSpriteTargetByName("Pico").size,
    "Nano": runtime.getSpriteTargetByName("Nano").size
  }
  e.scheduler
    // Execute 4 events after each other.
   .forEach([1, 2, 3, 4], (prev) => {
     return prev.pressKey('g').log(() => {
       e.out.group("Test if sprites get bigger", () => {
         for (const sprite in oldSize) {
           const newSize = runtime.getSpriteTargetByName(sprite).size;
           e.out.test(`${sprite} got bigger`)
            .expect(newSize > oldSize[sprite])
            .toBe(true);
           // Save the new size as the old one.
           oldSize[sprite] = newSize;
         }
       })
     });
   }).forEach([1, 2, 3, 4], (prev) => {
    return prev.pressKey('s').log(() => {
      e.out.group("Test if sprites get smaller", () => {
        for (const sprite in oldSize) {
          const newSize = runtime.getSpriteTargetByName(sprite).size;
          e.out.test(`${sprite} got smaller`)
           .expect(newSize < oldSize[sprite])
           .toBe(true);
          oldSize[sprite] = newSize;
        }
      })
    });
  })
   .end();
}
