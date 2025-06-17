# dsal-c
dsa: Data Structures and Algorithms in C

## Environment
### Development
#### Tooling
##### Format and Lint
Nix Format
```sh
alejandra <target>
```

C Format
```sh
# Clang Format
c-format-all
```

C Lint
```sh
# Clang Lint
c-lint-all

# Clang Lint and Fix
c-lint-all-fix
```

### Production
```sh
# Restart Docker
orb restart docker

# Create image
docker build -t dsal-c:dev .

# Build ephemeral container
docker run --rm dsal-c:dev

# Destroy image
docker rmi dsal-c:dev
```
