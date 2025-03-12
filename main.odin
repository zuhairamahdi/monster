package main

import "core:fmt"
import rl "vendor:raylib"


SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450

Player :: struct {
    position: rl.Vector2,
    speed: f32,
    color: rl.Color
}

move_player :: proc(player: ^Player) {
    if rl.IsKeyDown(.RIGHT) {
        player.position.x += player.speed
    }else if rl.IsKeyDown(.LEFT) {
        player.position.x -= player.speed
    } else if rl.IsKeyDown(.UP) {
        player.position.y -= player.speed
    }else if rl.IsKeyDown(.DOWN) {
        player.position.y += player.speed
    }
}
main :: proc() {
    rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "monster game")

    rl.SetTargetFPS(60)
    player := Player{rl.Vector2{50, 50}, 1.0, rl.RED}
    for rl.WindowShouldClose() == false {
        move_player(&player)
        rl.BeginDrawing()

        rl.ClearBackground(rl.BLACK)
        // print rectangle
        rl.DrawRectangle(cast(i32)player.position.x, cast(i32)player.position.y, 100, 100, rl.RED)        

        rl.EndDrawing()
    }

    rl.CloseWindow()
}