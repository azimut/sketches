import pygame
from pygame.locals import QUIT

# order?: show tablero, show pieces, win check

fps      = 60
ventanaH = 900
ventanaV = 900
blanco   = (0,255,255)

def gano(tablero, piezas):
    t = tablero # - _ | | \ /
    return t[0:3] == piezas \
        or t[6:9] == piezas \
        or t[0] + t[3] + t[6] == piezas \
        or t[2] + t[5] + t[8] == piezas \
        or t[0] + t[4] + t[8] == piezas \
        or t[2] + t[4] + t[6] == piezas

def coordenada_a_indice(x,y):
    return int(x/300) + int(y/300) * 3

class Grid:
    def __init__(self):
        self.imagex = pygame.image.load("imagenes/xblue.png")
        self.imageo = pygame.image.load("imagenes/ored.png")
        self.image = pygame.image.load("imagenes/grid.png")
        self.ancho, self.alto = self.image.get_size()
        self.tablero = ["#","#","#","#","#","#","#","#","#"]
        self.turno = "x"
        self.font = pygame.font.Font(None, 104)
    def mostrar(self, ventana):
        i = 0
        ventana.blit(self.image, (0,0))
        for y in [0,300,600]:
            for x in [0,300,600]:
                if self.tablero[i] != "#":
                    if self.tablero[i] == "x":
                        ventana.blit(self.imagex, (x,y))
                    else:
                        ventana.blit(self.imageo, (x,y))
                i += 1
    def ganaste(self):
        return gano(self.tablero, ["x","x","x"])
    def perdiste(self):
        return gano(self.tablero, ["o","o","o"]) or not ("#" in self.tablero)
    def jugar(self, x, y):
        indice = coordenada_a_indice(x,y)
        if self.tablero[indice] != "#":
            return
        self.tablero[indice] = self.turno
        if self.turno == "x":
            self.turno = "o"
        else:
            self.turno = "x"
    def terminar_juego(self, ventana):
        if self.ganaste():
            text_surface = self.font.render("GANASTE!", True, (0,200,30))
            ventana.blit(text_surface, text_surface.get_rect(center=(int(ventanaH/2),int(ventanaV/2))))
        elif self.perdiste():
            text_surface = self.font.render("PERDiSTE!", True, (200,0,0))
            ventana.blit(text_surface, text_surface.get_rect(center=(int(ventanaH/2),int(ventanaV/2))))

def main():
    pygame.init()
    ventana = pygame.display.set_mode((ventanaH,ventanaV))
    grid = Grid()
    jugando = True
    while jugando:
        ventana.fill(blanco)
        grid.mostrar(ventana)
        grid.terminar_juego(ventana)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                jugando = False
            if event.type == pygame.MOUSEBUTTONUP:
                grid.jugar(event.pos[0],event.pos[1])

        pygame.display.flip()
        pygame.time.Clock().tick(fps)

if __name__ == '__main__':
    main()
