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
    player_spritesheet := rl.LoadTexture("assets/player.png")

    rl.SetTargetFPS(60)
    player := Player{rl.Vector2{50, 50}, 1.0, rl.RED}
    for rl.WindowShouldClose() == false {
        move_player(&player)
        rl.BeginDrawing()

        rl.ClearBackground(rl.BLACK)
        sourceRec := rl.Rectangle{0, 0, 16, 16} // Adjust the x and y to select different sprites
        scale :f32 = 4.0 // Scale factor
        destRec := rl.Rectangle{player.position.x, player.position.y, sourceRec.width * scale, sourceRec.height * scale}
        origin := rl.Vector2{sourceRec.width * scale / 2, sourceRec.height * scale / 2}

        // Draw the scaled sprite
        rl.DrawTexturePro(player_spritesheet, sourceRec, destRec, origin, 0.0, rl.WHITE)
        rl.EndDrawing()
    }
    rl.UnloadTexture(player_spritesheet)
    rl.CloseWindow()
}