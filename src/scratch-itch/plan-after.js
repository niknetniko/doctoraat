function duringExecution(e) {
  // Schedule pressing each key four times in succession.
  e.scheduler
   .forEach([1, 2, 3, 4], (prev) => prev.pressKey('g'))
   .forEach([1, 2, 3, 4], (prev) => prev.pressKey('s'))
   .end();
}

function afterExecution(e) {
  const sprites = ["Giga", "Pico", "Nano"];

  // Get the events for the g key presses.
  const gPresses = e.log.events.filter((e) => e.type === 'key' && e.data.key === 'g');
  for (const event of gPresses) {
    e.out.group("Test if sprites get bigger", () => {
      for (const name of sprites) {
        // Get the sprite from the snapshot before the key press.
        const before = event.previous.sprite(name);
        // Get the sprite from the snapshot after the key press.
        const after = event.next.sprite(name);

        e.out.test(`${name} got bigger`)
         .expect(after.size > before.size)
         .toBe(true);
      }
    });
  }

  const sPresses = e.log.events.filter((e) => e.type === 'key' && e.data.key === 's');
  for (const event of sPresses) {
    e.out.group("Test if sprites get smaller", () => {
      for (const name of sprites) {
        const before = event.previous.sprite(name);
        const after = event.next.sprite(name);

        e.out.test(`${name} got smaller`)
         .expect(after.size < before.size)
         .toBe(true);
      }
    });
  }
}
