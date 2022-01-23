from __future__ import annotations
from typing import Optional
import json


class Recipe:
    def __init__(self, definition: dict):
        self.items = definition.get('items', [])
        self.method = definition['method']

    def __str__(self) -> str:
        return f'{self.method}, from items: {self.items}'


class Item:
    def __init__(self, definition: dict):
        self.mod_origin = definition.get('mod_origin', '(builtin)')

        self.recipes = []
        for recipe in definition.get('recipes', []):
            if recipe['items'] is not None:
                self.recipes.append(Recipe(recipe))

    def __eq__(self, other: Item) -> bool:
        if len(self.recipes) != len(other.recipes):
            return False
        for recipe in self.recipes:
            if recipe not in other.recipes:
                return False
        for recipe in other.recipes:
            if recipe not in other.recipes:
                return False

        return True


class Game:
    def __init__(self, file_name: str):
        with open(file_name, 'r') as f:
            data = json.load(f)
        self.aliases = data['aliases']
        self.items = {}

        for name, item_def in data['items'].items():
            self.items[name] = Item(item_def)

    def item(self, name: str) -> Optional[Item]:
        try:
            return self.items[self.resolve_name(name)]
        except KeyError:
            return None

    def resolve_name(self, name: str) -> str:
        try:
            return self.aliases[name]
        except KeyError:
            pass
        if not name:
            return '(hand)'
        return name

    def lint_uncraftable_recipes(self):
        already_printed = []

        for name, item in self.items.items():
            name = self.resolve_name(name)
            for recipe in item.recipes:
                for recipe_item in recipe.items:
                    if recipe_item is None:
                        # That's ok
                        continue

                    if (name, recipe_item) in already_printed:
                        continue

                    already_printed.append((name, recipe_item))

                    if not self.item(recipe_item) and not recipe_item.startswith('group:'):
                        print(f'Recipe for {name} references unknown item: `{recipe_item}`')

    def diff(self, other: Game):
        added_items = []
        changed_items = []
        deleted_items = []

        for name, item in self.items.items():
            # name = self.resolve_name(name)
            if name not in other.items:
                deleted_items.append((name, item))

        for name, item in other.items.items():
            # name = self.resolve_name(name)
            if name not in self.items:
                added_items.append((name, item))

        for name, item in other.items.items():
            if (name, item) in added_items:
                continue

            if item != self.items[name]:
                changed_items.append(name)

        for name, item in added_items:
            print(f'+++: {name}')
            for recipe in item.recipes:
                print(f'   > Recipe: {recipe}')

        for name, item in deleted_items:
            try:
                alias = other.aliases[name]
                print(f'---: {name}  [NAME ALIASED TO {alias}]')
                continue
            except KeyError:
                pass

            print(f'---: {name}')

        # for item in changed_items:
        #     print(f'+/-: {item if item else "(hand)"}')


if __name__ == '__main__':
    original = Game('../../../worlds/abcdef/master.json')
    compared = Game('../../../worlds/abcdef/game-snapshot.json')
    compared.lint_uncraftable_recipes()
    original.diff(compared)
