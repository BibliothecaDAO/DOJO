# World

The World is the center of any ECS system. All components, systems and entities live in the world. It contains general get functions for reading the game state.

All events from the world emit from this contract.

All executions in the world enter this contract. Users will only interact with this contract and never systems or components directly.
