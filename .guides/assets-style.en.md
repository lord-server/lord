# Artistic Requirements
[Русский](assets-style.ru.md) | **English**

For convenience of references, provisions of this agreement are numbered.

## I. Two-dimensional graphic elements
Include: block and model textures, item sprites, GUI graphic elements and
other images.

1. **General provisions for textures**:
	1. The main texture resolution is 16px by 16px;
	2. As an exception, it is allowed to use additional texture resolutions for blocks and items;
	3. The additional texture resolution is 32px by 32px;
	4. As an exception, it is allowed to use odd and non-standard texture resolutions for particles and GUI;
	5. All textures must undergo color indexing via optipng utility before being added to the game;
	6. Recommended: use limited texture palette with specific color positions. Recommended set for one shade: from 3 to 5;
	7. Texture palette should use hue shifting;

2. **Provisions for item textures (in inventory)**:
	1. Item textures must be easily distinguishable, not allowing ambiguous interpretation;
	2. Item textures must have an outline;
	3. The outline on item texture should follow the tone of the texture itself and have light-shadow transition;

3. **Provisions for block textures**:
	1. Blocks that do not imply a clearly distinguishable pattern must be seamless;

4. **Provisions for model textures**:
	1. The resolution of model textures (unwraps) may differ from the resolutions set in "1. General provisions for textures";
	2. The resolution of model textures (unwraps) is recommended to be created equal to powers of two (8, 16, 32, 64, 128, etc.);

## II. Three-dimensional graphic elements
Include: three-dimensional models of blocks and entities.

1. **General provisions for models**:
	1. In cases where the model is primitive, it is recommended to use nodebox for performance purposes;
	2. The used model formats are: *.obj or .glb* (under question);
	3. Source model files (Blender, Blockbench projects, etc.) must be saved in the repository;
	4. *In models, it is forbidden to use rounded or spherical elements, faces, polyhedron shapes. The model must be built from planes and/or parallelepipeds;*
	5. The faces and planes of the model must be strictly multiples of the pixels of their textures;
	6. The scale of the model unwrap must be uniform across the entire surface;
	7. The scale of the model unwrap is recommended to correlate with the main texture resolution as 1 to 1 or be visually close to this value.
