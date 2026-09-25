import pygame
import random

fps      = 60
ventanaH = 900
ventanaV = 900
blanco   = (30,30,30)

class Grid:
    def __init__(self):
        self.imagen = pygame.image.load("imagenes/cell.png")
        self.tablero = [0,1,2,3,4,5,6,7,8]
        random.shuffle(self.tablero)
        self.font = pygame.font.Font(None, 84)
    def mostrar(self, ventana):
        for y in [0,300,600]:
            for x in [0,300,600]:
                pieza = self.tablero[int(x/300)+int(y/300)*3]
                if pieza > 0:
                    ventana.blit(self.imagen,(x,y))
                    text_surface = self.font.render(str(pieza), True, (30,30,30))
                    ventana.blit(text_surface, (x+130,y+120))

def main():
    pygame.init()
    ventana = pygame.display.set_mode((ventanaH,ventanaV))
    jugando = True
    grid = Grid()
    while jugando:
        ventana.fill(blanco)
        grid.mostrar(ventana)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                jugando = False
        pygame.display.flip()
        pygame.time.Clock().tick(fps)

if __name__ == '__main__':
    main()
