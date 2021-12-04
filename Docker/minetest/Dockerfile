FROM weqqr/minetest:5.4.1
COPY . /usr/local/share/minetest/games/lord
EXPOSE 30000
ENTRYPOINT [ "minetestserver" ]
CMD [ "--config", "/usr/local/share/minetest/games/lord/server.conf" ]
