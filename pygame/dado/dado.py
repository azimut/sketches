import pygame
from pygame.locals import QUIT
import random

fps      = 5
ventanaH = 900
ventanaV = 500
fondo_sorteo = (120,120,0)
fondo_pausa = (20,20,20)
fondo = fondo_pausa

class Cubilete:
    def __init__(self):
        self.dados = [Dado(),Dado(),Dado()]
    def mostrar(self, ventana):
        for i, dado in enumerate(self.dados):
            dado.mostrar(ventana, i * 300, ventanaV/2 - 150)
            dado.mover()
    def pausar(self):
        for dado in self.dados:
            dado.animar = False
            dado.actual = random.choice([1,2,3,4,5,6])
    def animar(self):
        for dado in self.dados:
            dado.animar = True


class Dado:
    def __init__(self):
        self.lado1 = pygame.image.load("imagenes/lado1.png")
        self.lado2 = pygame.image.load("imagenes/lado2.png")
        self.lado3 = pygame.image.load("imagenes/lado3.png")
        self.lado4 = pygame.image.load("imagenes/lado4.png")
        self.lado5 = pygame.image.load("imagenes/lado5.png")
        self.lado6 = pygame.image.load("imagenes/lado6.png")
        self.actual = random.choice([1,2,3,4,5,6])
        self.animar = False
    def mover(self):
        if self.animar:
            self.actual = ((self.actual + 1) % 6) + 1
    def mostrar(self, ventana, x, y):
        centro = ventanaH/2 - 150
        if self.actual == 1:
            ventana.blit(self.lado1, (x,y))
        if self.actual == 2:
            ventana.blit(self.lado2, (x,y))
        if self.actual == 3:
            ventana.blit(self.lado3, (x,y))
        if self.actual == 4:
            ventana.blit(self.lado4, (x,y))
        if self.actual == 5:
            ventana.blit(self.lado5, (x,y))
        if self.actual == 6:
            ventana.blit(self.lado5, (x,y))




def main():
    pygame.init()
    ventana = pygame.display.set_mode((ventanaH,ventanaV))
    pygame.display.set_caption("pong")
    cubilete = Cubilete()
    jugando = True
    global fondo
    while jugando:
        ventana.fill(fondo)
        cubilete.mostrar(ventana)
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_SPACE:
                   cubilete.animar()
                   fondo = fondo_sorteo
            if event.type == pygame.KEYUP:
                if event.key == pygame.K_SPACE:
                   fondo = fondo_pausa
                   cubilete.pausar()
            if event.type == QUIT:
                jugando = False
        pygame.display.flip()
        pygame.time.Clock().tick(fps)

if __name__ == '__main__':
    main()
