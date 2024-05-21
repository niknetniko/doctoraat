# Dissertation (_proefschrift_)

De bronbestanden voor de tekst van mijn proefschrift.
De actie gebeurt in de map `src/`.

Bij een installatie van TeXLive kan je `src/main.tex` compileren met `latexmk`, en er zal een proefschrift tevoorschijn komen (na wat tijd, 6 minuten is geen uitzondering).
Mensen met Nix kunnen ook `nix build` uitvoeren in de repo.

Wat meer informatie:

- Startpunt is `src/main.tex`.
- Gebruikt KomaScript met LuaLatex, met Source Serif, Source Sans, en Source Code Pro.
- Alle grafieken en diagrammen zijn met TikZ/PGFPlots gemaakt (deels vandaar de lange compilatietijd).
- Alle andere afbeeldingen zijn waar mogelijk PDF.
- Er is een configuratie voor `vale`, maar dit genereert nog foutnegatieven door het gebrek aan ondersteuning voor het LaTeX-formaat.

De kaft krijg je door `nix build .#cover`, of `latexmk` met het bestand `src/cover/cover.tex`.
Merk op dat de kaftillustratie onder licentie aan mij is; gebruik die niet zonder toestemming!
(Die zou eigenlijk zelfs niet in de repository mogen zitten)

----

The source files for the text of my dissertation.
The action is in the `src/` folder.

With an installation of TeXLive, you can compile `src/main.tex` with `latexmk` and the dissertation will appear (after some time, 6 minutes or more is not an exception).
People using Nix might also run `nix build`.

More information:

- Starting point is `src/main.tex`.
- Uses KomaScript with LuaLatex, with Source Serif, Source Sans, and Source Code Pro.
- All graphs and visualizations are done using TikZ/PGFPlots (partly why the compile time is so high).
- All other images are PDF where possible.
- There is configuration for `vale`, but this generates false positives due to a lack of support for the LaTeX format.

You can get the over by doing `nix build .#cover`, or `latexmk` on the file `src/cover/cover.tex`.
Note that the cover illustration is licenced to me; do not use it without permission!
(It is probably not allowed to even be in this repository)
